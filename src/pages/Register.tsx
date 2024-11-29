import { useNavigate } from "react-router-dom";
import React, { useState } from "react";
import BASE_URL from "../services/WebServices.tsx";
import "./formStyles.css";

const Register: React.FC = () => {
    const navigate = useNavigate();
    const [username, setUsername] = useState<string | null>(null);

    const registrarUsuario = async (event: React.FormEvent<HTMLFormElement>) => {
        event.preventDefault();
        const dataForm = new FormData(event.currentTarget);

        const rutaServicio = `${BASE_URL}/db_create_user_game.php`;
        let formData = new FormData();
        formData.append("username", dataForm.get("usuario") as string);
        formData.append("email", dataForm.get("email") as string);
        formData.append("password", dataForm.get("clave") as string);
        formData.append("created_by", "system");

        try {
            const response = await fetch(rutaServicio, { method: "POST", body: formData });
            const result = await response.json();

            if (result.error) {
                alert(`Error: ${result.error}`);
            } else {
                alert("Registration successful");
                navigate("/Login");
            }
        } catch (error) {
            console.error("Connection error:", error);
            alert("Server connection error.");
        }
    };

    const loggedInUsername = localStorage.getItem("username");

    if (loggedInUsername) {
        return <p>You are already logged in, please log out first {loggedInUsername}</p>;
    }

    return (
        <section className="form-container">
            <div className="form-content">
                <h2 className="form-title">Register</h2>
                <form onSubmit={registrarUsuario}>
                    <div className="form-group">
                        <input type="text" className="form-control" required
                            name="usuario" placeholder="Username" />
                    </div>
                    <div className="form-group">
                        <input type="email" className="form-control" required
                            name="email" placeholder="Email" />
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
                            Register
                        </button>
                    </div>
                </form>
            </div>
        </section>
    );
};

export default Register;