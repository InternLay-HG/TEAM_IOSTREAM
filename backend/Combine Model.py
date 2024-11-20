from transformers import AutoTokenizer, AutoModelForSequenceClassification, pipeline
import torch
from langdetect import detect

# Load the Hindi-specific model
hindi_model_name = "Hate-speech-CNERG/hindi-abusive-MuRIL"
hindi_tokenizer = AutoTokenizer.from_pretrained(hindi_model_name)
hindi_model = AutoModelForSequenceClassification.from_pretrained(hindi_model_name)

# Load the English toxicity detection model
toxicity_model = pipeline("text-classification", model="unitary/toxic-bert")

# Function to analyze Hindi text toxicity
def check_hindi_toxicity(text, threshold=0.95):
    inputs = hindi_tokenizer(text, return_tensors="pt", padding=True, truncation=True, max_length=512)
    outputs = hindi_model(**inputs)
    probabilities = torch.softmax(outputs.logits, dim=1)
    abusive_prob = probabilities[0, 1].item()  # Probability for 'abusive' class
    return abusive_prob >= threshold, abusive_prob  # (is_toxic, probability)

# Function to analyze English text toxicity
def check_english_toxicity(text, threshold=0.95):
    result = toxicity_model(text)[0]
    return result['label'] == 'toxic' and result['score'] >= threshold, result['score']

# Unified function for analyzing text
def analyze_message(message, threshold_hindi=0.94, threshold_english=0.95):
    # Automatically detect language
    try:
        language = detect(message)
    except Exception as e:
        print(f"Error detecting language: {e}")
        return True  # Allow the message by default if language cannot be determined

    # Process based on detected language
    if language == "hi":  # Hindi
        is_toxic, score = check_hindi_toxicity(message, threshold_hindi)
        print(f"[Hindi Model] Detected Language: {language}, Toxic: {is_toxic}, Score: {score}")
    elif language == "en":  # English
        is_toxic, score = check_english_toxicity(message, threshold_english)
        print(f"[English Model] Detected Language: {language}, Toxic: {is_toxic}, Score: {score}")
    else:
        print(f"Unsupported language detected: {language}. Allowing the message.")
        return True  # Allow messages in unsupported languages

    return not is_toxic  # Return True if the message is allowed, False otherwise

# Test messages
messages = [
    "तुम बहुत गंदे हो।",  # Hindi
    "You're so stupid and annoying",  # English
    "।",  # Invalid Hindi input
    "Bonjour, comment ça va?"  # French (unsupported language)
]

# Analyze each message
for message in messages:
    print(f"Analyzing Message: \"{message}\"")
    if analyze_message(message):
        print("Result: Message is allowed.\n")
    else:
        print("Result: Message is blocked for toxicity.\n")
