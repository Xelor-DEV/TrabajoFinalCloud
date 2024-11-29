import banner1 from '../assets/images/Logo.png';
import './MainHeader.css'; // Importa el archivo CSS

function MainHeader() {
    return (
        <header id="main-header">
            <div className='container'>
                <img src={banner1} alt="Logo" style={{ float: 'left', marginRight: '10px', width: '100px', height: 'auto' }} />
                <h1>Xelor-DEV</h1>
                <p>Portfolio with some mini-games developed connected to a database</p>
            </div>
        </header>
    )
}
export default MainHeader;