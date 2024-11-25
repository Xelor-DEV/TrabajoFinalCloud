import { useNavigate } from "react-router-dom";
import React, { useState } from "react";
import BASE_URL from "../services/WebServices.tsx";

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
                alert(`Bienvenido, ${username}`);
                setUserId(result.userId);
                localStorage.setItem("userId", result.userId);
                localStorage.setItem("username", dataForm.get("usuario") as string);
                window.dispatchEvent(new Event('storage'));
                onLogin(result.userId);
                navigate("/");
            } else if (result.message === "Login failed") {
                alert(result.error || "Credenciales incorrectas.");
            }
        } catch (error) {
            console.error("Error en la conexión:", error);
            alert("Error en la conexión al servidor.");
        }
    };

    const username = localStorage.getItem("username");

    if (username) {
        return <p>Ya estás logeado {username}</p>;
    }

    return (
        <section className="padded">
            <div className="container">
                <div className="row">
                    <div className="col-md-4"></div>
                    <div className="col-md-4">
                        <h2 className="text-center">Iniciar sesión</h2>
                        <form onSubmit={iniciarSesion}>
                            <div className="mb-2">
                                <input type="text" className="form-control" required
                                    name="usuario" placeholder="Usuario" />
                            </div>
                            <div className="mb-2">
                                <input type="password" className="form-control" required id="txtClave"
                                    name="clave" placeholder="Contraseña" />
                                <input type="checkbox" className="form-check-input"
                                    onClick={(event) => {
                                        const target = event.target as HTMLInputElement;
                                        document.getElementById("txtClave")?.setAttribute("type",
                                            target.checked ? "text" : "password");
                                    }} />
                                <label className="form-check-label">&nbsp;Mostrar contraseña</label>
                            </div>
                            <div className="mb-2">
                                <button type="submit" className="btn btn-primary w-100">
                                    Iniciar sesión &gt;
                                </button>
                            </div>
                        </form>
                    </div>
                    <div className="col-md-4"></div>
                </div>
            </div>
        </section>
    );
};

export default Login;