const UserService = require("../services/user-service");
const userService = new UserService();

const signup = async (req, res) => {
    try {
        const response = await userService.signup({
            email: req.body.email,
            password: req.body.password,
            name: req.body.name
        });
        return res.status(201).json({
            success: true,
            message: 'Successfully created a new user',
            data: response,
            err: {}
        });
    } catch (err) {
        console.error(err);
        return res.status(500).json({
            message: 'Something went wrong',
            data: {},
            success: false,
            err: err.message
        });
    }
};

const login = async (req, res) => {
    try {
        const token = await userService.signin(req.body);
        return res.status(200).json({
            success: true,
            message: 'Successfully logged in',
            data: token,
            err: {}
        });
    } catch (error) {
        return res.status(500).json({
            message: 'Something went wrong',
            data: {},
            success: false,
            err: error
        });
    }
};

const getUserById = async (req, res) => {
    try {
        const user = await userService.getUserById(req.params.id);
        if (!user) {
            return res.status(404).json({
                success: false,
                message: 'User not found',
                data: {}
            });
        }
        return res.status(200).json({
            success: true,
            message: 'User retrieved successfully',
            data: user,
            err: {}
        });
    } catch (error) {
        return res.status(500).json({
            message: 'Something went wrong',
            data: {},
            success: false,
            err: error
        });
    }
};

const updateUser = async (req, res) => {
    try {
        const updatedUser = await userService.updateUser(req.params.id, req.body);
        return res.status(200).json({
            success: true,
            message: 'User updated successfully',
            data: updatedUser,
            err: {}
        });
    } catch (error) {
        return res.status(500).json({
            message: 'Something went wrong',
            data: {},
            success: false,
            err: error
        });
    }
};

const deleteUser = async (req, res) => {
    try {
        const result = await userService.deleteUser(req.params.id);
        if (!result) {
            return res.status(404).json({
                success: false,
                message: 'User not found',
                data: {}
            });
        }
        return res.status(200).json({
            success: true,
            message: 'User deleted successfully',
            data: {},
            err: {}
        });
    } catch (error) {
        return res.status(500).json({
            message: 'Something went wrong',
            data: {},
            success: false,
            err: error
        });
    }
};

module.exports = {
    signup,
    login,
    getUserById,
    updateUser,
    deleteUser
};
