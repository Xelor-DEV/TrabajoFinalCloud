import { useNavigate } from "react-router-dom";
import React, { useState } from "react";
import BASE_URL from "../services/WebServices.tsx";
import "./formStyles.css";

interface LoginProps {
    onLogin: (userId: number) => void;
}

const Login: React.FC<LoginProps> = ({ onLogin }) => {
    const navigate = useNavigate();
    const [userId, setUserId] = useState<number | null>(null);

    const iniciarSesion = async (event: React.FormEvent<HTMLFormElement>) => {
        event.preventDefault();
        const dataForm = new FormData(event.currentTarget);

        const rutaServicio = `${BASE_URL}/db_create_login.php`;
        let formData = new FormData();
        formData.append("username", dataForm.get("usuario") as string);
        formData.append("password", dataForm.get("clave") as string);

        try {
            const response = await fetch(rutaServicio, { method: "POST", body: formData });
            const result = await response.json();

            if (result.error) {
                alert(`Error: ${result.error}`);
            } else if (result.message === "Login successful" && result.userId) {
                const username = dataForm.get("usuario") as string;
                alert(`Welcome, ${username}`);
                setUserId(result.userId);
                localStorage.setItem("userId", result.userId);
                localStorage.setItem("username", dataForm.get("usuario") as string);
                window.dispatchEvent(new Event('storage'));
                onLogin(result.userId);
                navigate("/");
            } else if (result.message === "Login failed") {
                alert(result.error || "Incorrect credentials.");
            }
        } catch (error) {
            console.error("Connection error:", error);
            alert("Server connection error.");
        }
    };

    const username = localStorage.getItem("username");

    if (username) {
        return <p>You are already logged in {username}</p>;
    }

    return (
        <section className="form-container">
            <div className="form-content">
                <h2 className="form-title">Login</h2>
                <form onSubmit={iniciarSesion}>
                    <div className="form-group">
                        <input type="text" className="form-control" required
                            name="usuario" placeholder="Username" />
                    </div>
                    <div className="form-group">
                        <input type="password" className="form-control" required id="txtClave"
                            name="clave" placeholder="Password" />
                        <div className="form-check">
                            <input type="checkbox" className="form-check-input"
                                onClick={(event) => {
                                    const target = event.target as HTMLInputElement;
                                    document.getElementById("txtClave")?.setAttribute("type",
                                        target.checked ? "text" : "password");
                                }} />
                            <label className="form-check-label">&nbsp;Show password</label>
                        </div>
                    </div>
                    <div className="form-group">
                        <button type="submit" className="form-button">
                            Login
                        </button>
                    </div>
                </form>
            </div>
        </section>
    );
};

export default Login;