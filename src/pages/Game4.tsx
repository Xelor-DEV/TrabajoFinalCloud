import {Unity, useUnityContext} from "react-unity-webgl";

function Game4() {
    const { unityProvider, sendMessage } = useUnityContext({
        loaderUrl: "/CLICK.loader.js",
        dataUrl: "/CLICK.data.unityweb",
        frameworkUrl: "/CLICK.framework.js.unityweb",
        codeUrl: "/CLICK.wasm.unityweb",
    });

    function handleRestartGame() {
        sendMessage("GameManager", "RestartGame");
    }

    return (
        <>
            <div className="centered-container">
                <div className="centered-content">
                    <h1 className="centered-title">Fruits Catch</h1>
                    <Unity unityProvider={unityProvider} className="centered-unity" />
                    <div className="centered-content">
                        <button onClick={handleRestartGame}>Restart Game</button>
                    </div>
                </div>
            </div>

        </>
    );
}


export default Game4