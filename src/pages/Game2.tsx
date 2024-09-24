import {Unity, useUnityContext} from "react-unity-webgl";

function Game2() {
    const { unityProvider, sendMessage } = useUnityContext({
        loaderUrl: "/sds.loader.js",
        dataUrl: "/sds.data.unityweb",
        frameworkUrl: "/sds.framework.js.unityweb",
        codeUrl: "/sds.wasm.unityweb",
    });

    function handleRestartGame() {
        sendMessage("GameManager", "RestartGame");
    }

    return (
        <>
            <div className="centered-container">
                <div className="centered-content">
                    <h1 className="centered-title">Yu-Gi-Oh Memory Game</h1>
                    <Unity unityProvider={unityProvider} className="centered-unity" />
                    <div className="centered-content">
                        <button onClick={handleRestartGame}>Restart Game</button>
                    </div>
                </div>
            </div>

        </>
    );
}


export default Game2