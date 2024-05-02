import { useRef, useState, useEffect } from "react"
import { useNavigate } from "react-router-dom"
import ReCAPTCHA from "react-google-recaptcha"
import axios from "axios"
import Swal from 'sweetalert2'
import { decodeJWT } from "../../javascript/decodeJWT"
import logo  from '../../assets/Logo4.png'
import '../../css/login.css'

export default function Login({url}){
    const [user, setUser] = useState("");
    const [password, setPassword] = useState("");
    const [captchaState, setCaptchaState] = useState(false);

    const navigate = useNavigate();
    const captcha = useRef(null);

    var options = { enableHighAccuracy: true, timeout: 5000, maximumAge: 0, };

    function success(pos) { 
        var crd = pos.coords; 
        console.log("Your current position is:"); 
        console.log(`Latitude : ${crd.latitude}`); 
        console.log(`Longitude: ${crd.longitude}`); 
        console.log(`More or less ${crd.accuracy} meters.`); 
    }

    function errors(err) {
        console.warn(`ERROR(${err.code}): ${err.message}`); 
    }
    
    useEffect(() => { 
        if (navigator.geolocation) { 
            navigator.permissions .query({ name: "geolocation" }) 
            .then(function (result) { 
                if (result.state === "granted") { 
                    navigator.geolocation.getCurrentPosition(success, errors, options)
                } else if (result.state === "prompt") { 
                    navigator.geolocation.getCurrentPosition(success, errors, options)
                } else if (result.state === "denied") { 
                    //If denied then you have to show instructions to enable location 
                }
            }); 
        } else { 
            console.log("Geolocation is not supported by this browser."); 
        } 
    }, []);

    const handleLogin = (e) => {
        e.preventDefault();

        if(!user || !password) {
            Swal.fire({
                icon: 'info',
                title: `Por favor llene todos los campos`
            });
        } else {
            if(captchaState) {
                axios.post(`${url}/auth/login`, {username: user, password: password})
                .then(res => {
                    const tokenDecoded = decodeJWT(res.data.token);

                    const userLogged = {
                        "idNumber": tokenDecoded.userId.idUser,
                        "idType": tokenDecoded.userId.idDocType,
                        "role": tokenDecoded.role
                    }

                    sessionStorage.setItem("userLogged", JSON.stringify(userLogged));
                    sessionStorage.setItem("token", JSON.stringify(res.data.token));

                    if(tokenDecoded.role == "CLIENT") {
                        Swal.fire({
                            icon: 'success',
                            title: `Bienvenid@ ${user}`
                        });

                        navigate("/cliente-inicio", {
                            replace: ("/inicio-sesion", true)
                        });
                    }
                })
                .catch(err => {
                    Swal.fire({
                        icon: 'error',
                        title: `Hubo un error al iniciar sesión` ,
                    });

                    console.log(err);
                })
            } else {
                Swal.fire({
                    icon: 'info',
                    title: `Por favor complete el reCAPTCHA para continuar`
                });
            }
        }
    }

    const validateCaptcha = () =>{
        if(captcha.current.getValue()) {
            setCaptchaState(true)
        }
    }

    return(
        <article id="loginCard" className="w-11/12 md:w-1/2 h-2/3 md:h-3/5 pt-6 md:pt-10 2xl:pt-6 rounded-2xl shadow-xl bg-gradient-to-b 
        from-red-light from-75% to-red-dark">
            <section className="flex flex-col items-center px-6 md:px-10 xl:px-8">
                <img src={logo} alt="Logo de Four Parks" className="w-24 h-24"/>
                    
                <section className="flex flex-col justify-between items-center w-full h-56 mt-6 md:mt-10 2xl:mt-8">
                    <input type="text" id="user" value={user} className="w-full p-3 rounded-md bg-white font-paragraph placeholder:text-gray-dark" 
                    placeholder="Usuario" onChange={(e) => setUser(e.target.value)} required></input>

                    <input type="password" id="password" value={password} className="w-full p-3 rounded-md bg-white font-paragraph placeholder:text-gray-dark" 
                    placeholder="Contraseña" onChange={(e) => setPassword(e.target.value)} required></input>

                    <ReCAPTCHA ref={captcha} sitekey="6LfEr8QpAAAAAHkHnuDZebwy-ZRwIYKLoVA5MmyR" onChange={validateCaptcha} />
                </section>

                <button className="mt-8 2xl:mt-6  md:px-20 px-16 py-3 bg-blue-dark hover:bg-blue-darkest rounded-xl text-white font-title font-semibold text-xl" 
                onClick={handleLogin}>Iniciar sesión</button>   
            </section>

            <hr className="h-0.5 mt-8 2xl:mt-6  rounded-full bg-white"></hr>
                    
            <div className="flex justify-center mt-4 font-paragraph text-sm text-white"> ¿Olvidó su contraseña?  
                <a href="/" className="ml-1 font-semibold text-white hover:text-blue-darkest"> Recuperar </a>
            </div>     
            
            <div className="flex justify-center mt-2 font-paragraph text-sm text-white"> ¿Aún no tiene una cuenta?  
                <a href="/registro" className="ml-1 font-semibold text-white hover:text-blue-darkest"> Regístrate </a>
            </div>     
        </article>
    )
}