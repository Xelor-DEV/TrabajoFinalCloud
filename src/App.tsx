import { BrowserRouter, Route, Routes } from 'react-router-dom'
import './App.css'
import Home from "./pages/Home.tsx";
import MainHeader from "./common/MainHeader.tsx";
import MainNav from "./common/MainNav.tsx";
import MainFooter from "./common/MainFooter.tsx";
import Game from "./pages/Game.tsx";
import Game2 from "./pages/Game2.tsx";
import Game3 from "./pages/Game3.tsx";
import Game4 from "./pages/Game4.tsx";
import Game5 from "./pages/Game5.tsx";
import Login from "./pages/Login.tsx";

function App() {
    return (
        <>
            <BrowserRouter>
                <MainHeader />
                <MainNav />
                <Routes>
                    <Route path='/' element={<Home/>}/>
                    <Route path='/SpaceWar' element={<Game/>}/>
                    <Route path='/Yu-Gi-Oh Memory Game' element={<Game2/>}/>
                    <Route path='/Sevenger Clicker' element={<Game3/>}/>
                    <Route path='/Fruits Catch' element={<Game4/>}/>
                    <Route path='/Bounce Invaders' element={<Game5/>}/>
                    <Route path='/Login' element={<Login onLogin={() => {}} />} />
                </Routes>
                <MainFooter />
            </BrowserRouter>
        </>
    );
}

export default App