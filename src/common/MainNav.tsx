import { Link, useLocation } from "react-router-dom";
import { useState, useEffect } from "react";
import "./MainNav.css"; // Importa el archivo CSS

function MainNav() {
    const [isLoggedIn, setIsLoggedIn] = useState<boolean>(!!localStorage.getItem("userId"));
    const location = useLocation();

    useEffect(() => {
        const handleStorageChange = () => {
            setIsLoggedIn(!!localStorage.getItem("userId"));
        };

        window.addEventListener("storage", handleStorageChange);
        return () => {
            window.removeEventListener("storage", handleStorageChange);
        };
    }, []);

    return (
        <nav className="navbar navbar-expand-lg sticky-top">
            <div className="container">
                <div className="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul className="navbar-nav me-auto mb-2 mb-lg-0">
                        <li className={`nav-item ${location.pathname === "/" ? "active" : ""}`}>
                            <Link className="nav-link" to="/">Home</Link>
                        </li>
                        {isLoggedIn && (
                            <>
                                <li className={`nav-item ${location.pathname === "/SpaceWar" ? "active" : ""}`}>
                                    <Link className="nav-link" to="/SpaceWar">SpaceWar</Link>
                                </li>
                                <li className={`nav-item ${location.pathname === "/Yu-Gi-Oh Memory Game" ? "active" : ""}`}>
                                    <Link className="nav-link" to="/Yu-Gi-Oh Memory Game">Yu-Gi-Oh Memory Game</Link>
                                </li>
                                <li className={`nav-item ${location.pathname === "/Sevenger Clicker" ? "active" : ""}`}>
                                    <Link className="nav-link" to="/Sevenger Clicker">Sevenger Clicker</Link>
                                </li>
                                <li className={`nav-item ${location.pathname === "/Fruits Catch" ? "active" : ""}`}>
                                    <Link className="nav-link" to="/Fruits Catch">Fruits Catch</Link>
                                </li>
                                <li className={`nav-item ${location.pathname === "/Bounce Invaders" ? "active" : ""}`}>
                                    <Link className="nav-link" to="/Bounce Invaders">Bounce Invaders</Link>
                                </li>
                            </>
                        )}
                        <li className={`nav-item ${location.pathname === "/Account" ? "active" : ""}`}>
                            <Link className="nav-link" to="/Account">Account</Link>
                        </li>
                        {!isLoggedIn && (
                            <>
                                <li className={`nav-item ${location.pathname === "/Login" ? "active" : ""}`}>
                                    <Link className="nav-link" to="/Login">Login</Link>
                                </li>
                                <li className={`nav-item ${location.pathname === "/Register" ? "active" : ""}`}>
                                    <Link className="nav-link" to="/Register">Register</Link>
                                </li>
                            </>
                        )}
                    </ul>
                </div>
            </div>
        </nav>
    );
}

export default MainNav;