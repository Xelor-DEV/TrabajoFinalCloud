import { useNavigate } from "react-router-dom";
import React, { useState } from "react";
import BASE_URL from "../services/WebServices.tsx";

const Update: React.FC = () => {
    const navigate = useNavigate();
    const [username, setUsername] = useState<string | null>(localStorage.getItem("username"));
    const [email, setEmail] = useState<string | null>(null);
    const [password, setPassword] = useState<string | null>(null);

    const actualizarDatos = async (event: React.FormEvent<HTMLFormElement>) => {
        event.preventDefault();
        const userId = localStorage.getItem("userId");
        if (!userId) return;

        const dataForm = new FormData(event.currentTarget);
        const rutaServicio = `${BASE_URL}/db_update_user_game.php`;
        let formData = new FormData();
        formData.append("userId", userId);
        formData.append("username", dataForm.get("usuario") as string);
        formData.append("email", dataForm.get("email") as string);
        formData.append("password", dataForm.get("clave") as string);
        formData.append("state", "1");
        formData.append("modified_by", "admin");

        try {
            const response = await fetch(rutaServicio, { method: "POST", body: formData });
            const result = await response.json();

            if (result.error) {
                alert(`Error: ${result.error}`);
            } else {
                alert("Datos actualizados exitosamente");
                const newUsername = dataForm.get("usuario") as string;
                localStorage.setItem("username", newUsername);
                setUsername(newUsername);
                window.dispatchEvent(new Event('storage'));
                navigate("/");
            }
        } catch (error) {
            console.error("Error en la conexión:", error);
            alert("Error en la conexión al servidor.");
        }
    };

    return (
        <section className="padded">
            <div className="container">
                <div className="row">
                    <div className="col-md-4"></div>
                    <div className="col-md-4">
                        <h2 className="text-center">Actualizar datos</h2>
                        <form onSubmit={actualizarDatos}>
                            <div className="mb-2">
                                <input type="text" className="form-control" required
                                    name="usuario" placeholder="Usuario" defaultValue={username || ""} />
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
                                    Actualizar datos &gt;
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

export default Update;