const express = require('express');
const { connect } = require('./config/database');
const passport = require('passport');
const passportAuth = require('./config/jwt-middleware'); 
const apiRoutes = require('./routes/auth-routes');

const app = express();


app.use(express.json());
app.use(express.urlencoded({ extended: true }));


app.use(passport.initialize());
passportAuth(passport); 

app.use('/api', apiRoutes);

const { PORT } = require('./config/server_config');


app.listen(PORT, async () => {
    console.log(`Server started on PORT: ${PORT}`);
    try {
        await connect();
        console.log('MongoDB connected');
    } catch (error) {
        console.error('Failed to connect to MongoDB:', error);
        process.exit(1);
    }
});
