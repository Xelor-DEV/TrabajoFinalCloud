import React from "react";
import { useNavigate } from "react-router-dom";
import BASE_URL from "../services/WebServices.tsx";
import "./Account.css";

const Account: React.FC = () => {
    const navigate = useNavigate();
    const username = localStorage.getItem("username");

    const logout = () => {
        localStorage.removeItem("userId");
        localStorage.removeItem("username");
        window.dispatchEvent(new Event('storage'));
        navigate("/");
    };

    const deleteAccount = async () => {
        const userId = localStorage.getItem("userId");
        if (!userId) return;

        const serviceRoute = `${BASE_URL}/db_delete_user_game.php`;
        let formData = new FormData();
        formData.append("user_id", userId);

        try {
            const response = await fetch(serviceRoute, { method: "POST", body: formData });
            const result = await response.json();

            if (result.error) {
                alert(`Error: ${result.error}`);
            } else {
                alert("Account successfully deleted");
                logout();
            }
        } catch (error) {
            console.error("Connection error:", error);
            alert("Server connection error.");
        }
    };

    if (!username) {
        return (
            <div className="account-container text-center">
                <p className="login-message">Please log in first</p>
            </div>
        );
    }

    return (
        <div className="account-container text-center">
            <h1 className="mb-4">Welcome, {username}</h1>
            <div className="btn-group-vertical">
                <button onClick={() => navigate("/Update")} className="btn btn-secondary btn-lg mb-2">Update data</button>
                <button onClick={logout} className="btn btn-primary btn-lg mb-2">Log out</button>        
                <button onClick={deleteAccount} className="btn btn-danger btn-lg">Delete account</button>
            </div>
        </div>
    );
};

export default Account;