import { Link } from "react-router-dom";
import { useState, useEffect } from "react";

function MainNav() {
    const [isLoggedIn, setIsLoggedIn] = useState<boolean>(!!localStorage.getItem("userId"));

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
        <nav className="navbar navbar-expand-lg bg-body-tertiary sticky-top bg-dark navbar-dark">
            <div className="container">
                <div className="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul className="navbar-nav me-auto mb-2 mb-lg-0">
                        <li className="nav-item">
                            <Link className="nav-link" to="/">Home</Link>
                        </li>
                        {isLoggedIn && (
                            <>
                                <li className="nav-item">
                                    <Link className="nav-link" to="/SpaceWar">SpaceWar</Link>
                                </li>
                                <li className="nav-item">
                                    <Link className="nav-link" to="/Yu-Gi-Oh Memory Game">Yu-Gi-Oh Memory Game</Link>
                                </li>
                                <li className="nav-item">
                                    <Link className="nav-link" to="/Sevenger Clicker">Sevenger Clicker</Link>
                                </li>
                                <li className="nav-item">
                                    <Link className="nav-link" to="/Fruits Catch">Fruits Catch</Link>
                                </li>
                                <li className="nav-item">
                                    <Link className="nav-link" to="/Bounce Invaders">Bounce Invaders</Link>
                                </li>
                            </>
                        )}
                        <li className="nav-item">
                            <Link className="nav-link" to="/Account">Account</Link>
                        </li>
                        {!isLoggedIn && (
                            <>
                                <li className="nav-item">
                                    <Link className="nav-link" to="/Login">Login</Link>
                                </li>
                                <li className="nav-item">
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