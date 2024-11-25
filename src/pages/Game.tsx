import {Unity, useUnityContext} from "react-unity-webgl";

function Game() {
    const { unityProvider, sendMessage } = useUnityContext({
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





    return (
        <>
            <div className="centered-container">
                <div className="centered-content">
                    <h1 className="centered-title">SpaceWar</h1>
                    <Unity unityProvider={unityProvider} className="centered-unity" />
                    <div className="centered-content">
                        <button onClick={handleRestartGame}>Restart Game</button>
                    </div>
                    <div className="centered-content">
                        <button onClick={handlePause}>Pause</button>
                    </div>

                </div>
            </div>

        </>
    );
}


export default Game