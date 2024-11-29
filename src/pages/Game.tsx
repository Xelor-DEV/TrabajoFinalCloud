import { Unity, useUnityContext } from "react-unity-webgl";
import { useEffect } from "react";
import "./styles.css"; // Asegúrate de importar el archivo CSS

function Game() {
    const { unityProvider, sendMessage, isLoaded, unload } = useUnityContext({
        loaderUrl: "/SpaceWar.loader.js",
        dataUrl: "/SpaceWar.data.unityweb",
        frameworkUrl: "/SpaceWar.framework.js.unityweb",
        codeUrl: "/SpaceWar.wasm.unityweb",
    });

    function handleRestartGame() {
        sendMessage("GameManager", "RestartGame");
    }
    function handlePause() {
        sendMessage("GameManager", "TogglePause");
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
                    <h1 className="centered-title">SpaceWar</h1>
                    <Unity unityProvider={unityProvider} className="centered-unity" />
                    <div className="centered-content">
                        <button className="button" onClick={handleRestartGame}>Restart (Game Over Only)</button>
                    </div>
                    <div className="centered-content">
                        <button className="button" onClick={handlePause}>Pause (Only Playing, Not at Game Over)</button>
                    </div>
                </div>
            </div>
        </>
    );
}

export default Game;