import { useNavigate } from "react-router-dom";
import React, { useState } from "react";
import BASE_URL from "../services/WebServices.tsx";

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
                alert("Registro exitoso");
                navigate("/Login");
            }
        } catch (error) {
            console.error("Error en la conexión:", error);
            alert("Error en la conexión al servidor.");
        }
    };

    const loggedInUsername = localStorage.getItem("username");

    if (loggedInUsername) {
        return <p>Tienes una sesión iniciada, cierra sesión primero {loggedInUsername}</p>;
    }

    return (
        <section className="padded">
            <div className="container">
                <div className="row">
                    <div className="col-md-4"></div>
                    <div className="col-md-4">
                        <h2 className="text-center">Registrarse</h2>
                        <form onSubmit={registrarUsuario}>
                            <div className="mb-2">
                                <input type="text" className="form-control" required
                                    name="usuario" placeholder="Usuario" />
                            </div>
                            <div className="mb-2">
                                <input type="email" className="form-control" required
                                    name="email" placeholder="Email" />
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
                                    Registrarse &gt;
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

export default Register;