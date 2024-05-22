import { Chart as ChartJS, CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend } from 'chart.js';
import { Bar } from 'react-chartjs-2';
import { useEffect, useState } from "react";
import axios from "axios";

ChartJS.register(CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend);

const BarHours = ({url, actualParking, startDate, endDate}) => {
    const [hoursAverage, setHoursAverage] = useState([]);

    useEffect(() => {
        const token = sessionStorage.getItem('token').replace(/"/g, '');
        setHoursAverage([]);
      
        axios.get(`${url}/getStatistics`, {
            initialDate: startDate,
            finalDate: endDate,
            idParking: actualParking.id
        }, {headers: {Authorization: `Bearer ${token}`}})
        .then((res) => {
            console.log(res.data)
            const hoursData = res.data
            .map(item => ({ nombre: item.hour, calificacion: item.average }));
      
            setHoursAverage(element => [...element, ...hoursData]);
        })
        .catch((err) => {
            console.log(err);
        });
    }, [actualParking, startDate, endDate]);      

    const labels = hoursAverage.map((item) => item.hour);
    const average = hoursAverage.map((item) => item.average);

    
    const customPastelColors = [
        'rgba(255, 182, 193, 0.8)',
    ];

    const data = {
        labels: labels,
        datasets: [{
            data: average,
            backgroundColor: customPastelColors,
            borderColor: customPastelColors,
            borderWidth: 1,
            label: 'Reservaciones',
        }]
    };

    const options = {
        plugins: {
            title: {
                display: true,
                text: '',
            },
        },
        scales: {
            y: {
                beginAtZero: true
            },
        },
    };

    return <Bar data={data} options={options} />;
};

export default BarHours;