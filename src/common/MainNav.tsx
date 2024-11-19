import { Link } from "react-router-dom"

function MainNav() {
    return (
        <nav className="navbar navbar-expand-lg bg-body-tertiary sticky-top bg-dark navbar-dark">
            <div className="container">
                <div className="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul className="navbar-nav me-auto mb-2 mb-lg-0">
                        <li className="nav-item">
                            <Link className="nav-link" to="/">Home</Link>
                        </li>
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
                        <li className="nav-item">
                            <Link className="nav-link" to="/Login">Login</Link>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    )
}

export default MainNav