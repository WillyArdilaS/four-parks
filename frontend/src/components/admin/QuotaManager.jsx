import React from 'react';
import { useState } from "react";

function QuotaManager({ url }) {
    //Cupos Cubiertos
    const [quotaCarCov, setQuotaCarCov] = useState('');
    const [quotaMotoCov, setQuotaMotoCov] = useState('');
    const [quotaBicCov, setQuotaBicCov] = useState('');
    //Cupos Descubiertos
    const [quotaCarUnc, setQuotaCarUnc] = useState('');
    const [quotaMotoUnc, setQuotaMotoUnc] = useState('');
    const [quotaBicUnc, setQuotaBicUnc] = useState('');
    //Tarifas Cubiertos
    const [RateCarCov, setRateCarCov] = useState('');
    const [RateMotoCov, setRateMotoCov] = useState('');
    const [RateBicCov, setRateBicCov] = useState('');
    //Tarifas Descubiertos
    const [RateCarUnc, setRateCarUnc] = useState('');
    const [RateMotoUnc, setRateMotoUnc] = useState('');
    const [RateBicUnc, setRateBicUnc] = useState('');


    return (
        <article className="w-full mt-12 py-4 rounded-2xl shadow-xl bg-blue-light">
            <section className='flex justify-center'>
                <div className='text-2xl font-semibold'> Administrar cupos </div>
            </section>

            <section className='mt-2 px-8'>
                <label className='text font-semibold text-xl'> Cubierto </label>
                
                <section className='flex flex-col'>
                    <label className='mt-5 mb-2 text font-semibold'> Automóvil </label>

                    <section className='flex justify-between'>
                        <div className='flex justify-between'>
                            <label className='text font-semibold pt-3'> # cupos </label>
                            <input type="number" className='mr-8 w-7/12 shadow-xl p-3 rounded-md bg-white font-paragraph placeholder:text-gray-dark' placeholder='20' 
                            value={quotaCarCov} onChange={(e) => setQuotaCarCov(e.target.value)}/>
                        </div>

                        <div className='flex justify-between'>
                            <label className='ml-8 text font-semibold pt-3'> Tarifa </label>
                            <input type="" className='w-2/3 shadow-xl p-3 rounded-md bg-white font-paragraph placeholder:text-gray-dark' placeholder='$25.000' 
                            value={RateCarCov} onChange={(e) => setRateCarCov(e.target.value)}/>
                        </div>
                    </section>
                </section>

                <section className='flex flex-col'>
                    <label className='mt-5 mb-2 text font-semibold'> Motocicleta </label>

                    <section className='flex justify-between'>
                        <div className='flex justify-between'>
                            <label className='text font-semibold pt-3'> # cupos </label>
                            <input type="number" className='mr-8 w-7/12 shadow-xl p-3 rounded-md bg-white font-paragraph placeholder:text-gray-dark' placeholder='20' 
                            value={quotaMotoCov} onChange={(e) => setQuotaMotoCov(e.target.value)}/>
                        </div>

                        <div className='flex justify-between'>
                            <label className='ml-8 text font-semibold pt-3'> Tarifa </label>
                            <input type="" className='w-2/3 shadow-xl p-3 rounded-md bg-white font-paragraph placeholder:text-gray-dark' placeholder='$15.000'
                            value={RateMotoCov} onChange={(e) => setRateMotoCov(e.target.value)}/>
                        </div>
                    </section>
                </section>

                <section className='flex flex-col'>
                    <label className='mt-5 mb-2 text font-semibold'> Bicicleta </label>

                    <section className='flex justify-between'>
                        <div className='flex justify-between'>
                            <label className='text font-semibold pt-3'> # cupos </label>
                            <input type="number" className='mr-8 w-7/12 shadow-xl p-3 rounded-md bg-white font-paragraph placeholder:text-gray-dark' placeholder='20' 
                            value={quotaBicCov} onChange={(e) => setQuotaBicCov(e.target.value)}/>
                        </div>

                        <div className='flex justify-between'>
                            <label className='ml-8 text font-semibold pt-3'> Tarifa </label>
                            <input type="" className='w-2/3 shadow-xl p-3 rounded-md bg-white font-paragraph placeholder:text-gray-dark' placeholder='$10.000' 
                            value={RateBicCov} onChange={(e) => setRateBicCov(e.target.value)}/>
                        </div>
                    </section>
                </section>
            </section>

            <hr className="h-0.5 mt-10 rounded-full bg-white"></hr>

            <section className='mt-5 mx-5 px-4'>
                <label className='text font-semibold text-lg'> Descubierto </label>

                <section className='flex flex-col'>
                    <label className='mt-5 mb-2 text font-semibold'> Automóvil </label>

                    <section className='flex justify-between'>
                        <div className='flex justify-between'>
                            <label className='text font-semibold pt-3'> # cupos </label>
                            <input type="number" className='mr-8 w-7/12 shadow-xl p-3 rounded-md bg-white font-paragraph placeholder:text-gray-dark' placeholder='20' 
                            value={quotaCarCov} onChange={(e) => setQuotaCarCov(e.target.value)}/>
                        </div>

                        <div className='flex justify-between'>
                            <label className='ml-8 text font-semibold pt-3'> Tarifa </label>
                            <input type="" className='w-2/3 shadow-xl p-3 rounded-md bg-white font-paragraph placeholder:text-gray-dark' placeholder='$25.000' 
                            value={RateCarCov} onChange={(e) => setRateCarCov(e.target.value)}/>
                        </div>
                    </section>
                </section>

                <section className='flex flex-col'>
                    <label className='mt-5 mb-2 text font-semibold'> Motocicleta </label>

                    <section className='flex justify-between'>
                        <div className='flex justify-between'>
                            <label className='text font-semibold pt-3'> # cupos </label>
                            <input type="number" className='mr-8 w-7/12 shadow-xl p-3 rounded-md bg-white font-paragraph placeholder:text-gray-dark' placeholder='20' 
                            value={quotaMotoCov} onChange={(e) => setQuotaMotoCov(e.target.value)}/>
                        </div>

                        <div className='flex justify-between'>
                            <label className='ml-8 text font-semibold pt-3'> Tarifa </label>
                            <input type="" className='w-2/3 shadow-xl p-3 rounded-md bg-white font-paragraph placeholder:text-gray-dark' placeholder='$15.000'
                            value={RateMotoCov} onChange={(e) => setRateMotoCov(e.target.value)}/>
                        </div>
                    </section>
                </section>

                <section className='flex flex-col'>
                    <label className='mt-5 mb-2 text font-semibold'> Bicicleta </label>

                    <section className='flex justify-between'>
                        <div className='flex justify-between'>
                            <label className='text font-semibold pt-3'> # cupos </label>
                            <input type="number" className='mr-8 w-7/12 shadow-xl p-3 rounded-md bg-white font-paragraph placeholder:text-gray-dark' placeholder='20' 
                            value={quotaBicCov} onChange={(e) => setQuotaBicCov(e.target.value)}/>
                        </div>

                        <div className='flex justify-between'>
                            <label className='ml-8 text font-semibold pt-3'> Tarifa </label>
                            <input type="" className='w-2/3 shadow-xl p-3 rounded-md bg-white font-paragraph placeholder:text-gray-dark' placeholder='$10.000' 
                            value={RateBicCov} onChange={(e) => setRateBicCov(e.target.value)}/>
                        </div>
                    </section>
                </section>
            </section>





            <section className='flex items-center justify-between w-full'>
                <button className='shadow-xl mt-8 px-20 py-3 mr-8 ml-8 bg-blue-dark hover:bg-blue-darkest rounded-xl text-white font-title font-semibold'>Confirmar
                </button>
                <button className='shadow-xl mt-8 px-20 py-3 mr-10 bg-red-dark hover:bg-red-darkest rounded-xl text-white font-title font-semibold'>Cancelar</button>

            </section>

        </article>




    )
}

export default QuotaManager;