import {Unity, useUnityContext} from "react-unity-webgl";
import { useEffect } from "react";
import "./styles.css"; // Asegúrate de importar el archivo CSS

function Game2() {
    const { unityProvider, sendMessage, isLoaded, unload } = useUnityContext({
        loaderUrl: "/Yu-Gi-OhMemoryGame.loader.js",
        dataUrl: "/Yu-Gi-OhMemoryGame.data.unityweb",
        frameworkUrl: "/Yu-Gi-OhMemoryGame.framework.js.unityweb",
        codeUrl: "/Yu-Gi-OhMemoryGame.wasm.unityweb",
    });

    function handleRestartGame() {
        sendMessage("GameManager", "RestartGame");
    }

    function sendUserId() {
        const userId = localStorage.getItem("userId");
        if (userId) {
            sendMessage("GameManager", "ReceiveUserId", userId);
        }
    }
    
    useEffect(() => {
        if (isLoaded) {
            sendUserId();
        }

        return () => {
            if (isLoaded) {
                unload();
            }
        };
    }, [isLoaded]);

    return (
        <>
            <div className="centered-container">
                <div className="centered-content">
                    <h1 className="centered-title">Yu-Gi-Oh Memory Game</h1>
                    <Unity unityProvider={unityProvider} className="centered-unity" />
                    <div className="centered-content">
                        <button className="button" onClick={handleRestartGame}>Restart Game</button>
                    </div>
                </div>
            </div>
        </>
    );
}

export default Game2;