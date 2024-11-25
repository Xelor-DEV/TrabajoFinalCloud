import React from "react";
import { useNavigate } from "react-router-dom";
import BASE_URL from "../services/WebServices.tsx";

const Account: React.FC = () => {
    const navigate = useNavigate();
    const username = localStorage.getItem("username");

    const cerrarSesion = () => {
        localStorage.removeItem("userId");
        localStorage.removeItem("username");
        window.dispatchEvent(new Event('storage'));
        navigate("/");
    };

    const eliminarCuenta = async () => {
        const userId = localStorage.getItem("userId");
        if (!userId) return;

        const rutaServicio = `${BASE_URL}/db_delete_user_game.php`;
        let formData = new FormData();
        formData.append("user_id", userId);

        try {
            const response = await fetch(rutaServicio, { method: "POST", body: formData });
            const result = await response.json();

            if (result.error) {
                alert(`Error: ${result.error}`);
            } else {
                alert("Cuenta eliminada exitosamente");
                cerrarSesion();
            }
        } catch (error) {
            console.error("Error en la conexión:", error);
            alert("Error en la conexión al servidor.");
        }
    };

    if (!username) {
        return <p>Logea primero</p>;
    }

    return (
        <div>
            <p>Bienvenido {username}</p>
            <button onClick={cerrarSesion} className="btn btn-primary">Cerrar sesión</button>
            <button onClick={() => navigate("/Update")} className="btn btn-secondary">Actualizar datos</button>
            <button onClick={eliminarCuenta} className="btn btn-danger">Eliminar cuenta</button>
        </div>
    );
};

export default Account;