import { Unity, useUnityContext } from "react-unity-webgl";
import { useEffect } from "react";

function Game4() {
    const { unityProvider, sendMessage, isLoaded } = useUnityContext({
        loaderUrl: "/FruitsCatch.loader.js",
        dataUrl: "/FruitsCatch.data.unityweb",
        frameworkUrl: "/FruitsCatch.framework.js.unityweb",
        codeUrl: "/FruitsCatch.wasm.unityweb",
    });

    function handleRestartGame() {
        sendMessage("GameManager", "ResetGame");
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
    }, [isLoaded]);

    return (
        <>
            <div className="centered-container">
                <div className="centered-content">
                    <h1 className="centered-title">Fruits Catch</h1>
                    <Unity unityProvider={unityProvider} className="centered-unity" />
                    <div className="centered-content">
                        <button onClick={handleRestartGame}>Restart (Game Over Only)</button>
                    </div>
                </div>
            </div>
        </>
    );
}

export default Game4;