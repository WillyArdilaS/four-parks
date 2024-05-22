import { useState, useEffect } from "react";
import axios from "axios";
import Header from "../../components/admin/Header"
import BarHours from "../../components/admin/graphics/BarHours";

const StatisticsAdminPage = ({url}) => {
  const [infoType, setInfoType] = useState('');
  const [graphicType, setGraphicType] = useState('');
  const [startDate, setStartDate] = useState('');
  const [endDate, setEndDate] = useState('');
  const [actualParking, setActualParking] = useState({
    id: "",
    name: ""
  });

  useEffect(() => {
    const token = sessionStorage.getItem('token').replace(/"/g, '');
    const user = JSON.parse(sessionStorage.getItem('userLogged'));
    
    axios.get(`${url}/parking/admin/${user.idType}/${user.idNumber}`, {headers: {Authorization: `Bearer ${token}`}})
    .then(res => {
        setActualParking({
          id: res.data.parking.parkingId.idParking, 
          name: res.data.parking.namePark
        });
    })
    .catch(err => {
        console.error(err);
    });
  }, []);

    const createHoursGraph = () => {
      if(actualParking && infoType && graphicType && startDate && endDate) {
        switch (graphicType) {
            case 'bars':
                return (
                  <section className="w-10/12 mt-5">
                      <div className="border bg-white p-6 rounded-md shadow-md overflow-hidden">
                        <BarHours url={url} actualParking={actualParking} startDate={startDate} endDate={endDate} />
                      </div>
                  </section> 
                );
            case 'circle':
                return null;
            case 'lines':
                return null;
            default:
                return null;
        }
      }
  };

  return (
    <>
        <Header />

        <section className='h-screen px-12 py-36 mb-28 bg-gray-light'>   
          <section className="flex justify-between w-full">
            <div id="statistics-parkings" className="w-1/6 h-12 mr-12 mb-6 p-3 rounded-md bg-white shadow-md font-paragraph"> {actualParking.name} </div>

            <select id="statistics-info" value={infoType} className="w-1/6 h-12 mr-12 mb-6 p-3 rounded-md bg-white shadow-md font-paragraph" 
            onChange={(e) => setInfoType(e.target.value)}>
                <option value="" disabled selected hidden> Tipo de información </option>
                <option value=""></option>
                <option value="hours"> Horas pico / valle </option>
                <option value="sales"> Ventas </option>
            </select>
            
            <select id="statistics-graphic" value={graphicType} className="w-1/6 h-12 mr-12 mb-6 p-3 rounded-md bg-white shadow-md font-paragraph"
            onChange={(e) => setGraphicType(e.target.value)}>
                <option value="" disabled selected hidden> Tipo de gráfica </option>
                <option value=""></option>
                <option value="circle"> Circular </option>
                <option value="bars"> Barras </option>
                <option value="lines"> Línea </option>
            </select>
            
            <input type="date" id="statistics-startDate" value={startDate} className="w-1/6 h-12 mr-12 mb-6 p-3 rounded-md bg-white shadow-md font-paragraph"
            onChange={(e) => setStartDate(e.target.value)}></input>
            
            <input type="date" id="statistics-endDate" value={endDate} className="w-1/6 h-12 mr-12 mb-6 p-3 rounded-md bg-white shadow-md font-paragraph"
            onChange={(e) => setEndDate(e.target.value)}></input>
          </section>

          {createHoursGraph()}
        </section>
    </>
  )
}

export default StatisticsAdminPage