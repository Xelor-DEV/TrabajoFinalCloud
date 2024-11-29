import {Unity, useUnityContext} from "react-unity-webgl";
import { useEffect } from "react";
import "./styles.css"; // Asegúrate de importar el archivo CSS

function Game3() {
    const { unityProvider, sendMessage, isLoaded, unload  } = useUnityContext({
        loaderUrl: "/SevengerClicker.loader.js",
        dataUrl: "/SevengerClicker.data.unityweb",
        frameworkUrl: "/SevengerClicker.framework.js.unityweb",
        codeUrl: "/SevengerClicker.wasm.unityweb",
    });

    function handleRestartGame() {
        sendMessage("GameManager", "RestartGame");
    }

    function handleSaveScore() {
        sendMessage("GameManager", "RegisterScore");
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
                    <h1 className="centered-title">Sevenger Clicker</h1>
                    <Unity unityProvider={unityProvider} className="centered-unity" />
                    <div className="centered-content">
                        <button className="button" onClick={handleSaveScore}> Save Score</button>
                    </div>
                    <div className="centered-content">
                        <button className="button" onClick={handleRestartGame}> Restart Game </button>
                    </div>
                </div>
            </div>
        </>
    );
}

export default Game3;