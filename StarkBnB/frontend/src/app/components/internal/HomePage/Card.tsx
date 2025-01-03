import React from 'react';
import Image from 'next/image';
import { CiStar } from "react-icons/ci";
import { FaStar } from "react-icons/fa6";

interface CardProps {
    title: string;
    imageUrl: string;
    rating: string;
    city: string;
    country: string;
    size: string;
    amount: string;
}


const Card: React.FC<CardProps> = ({title, imageUrl, rating, city, country, size, amount}) => {
  return (
    // hover:shadow-2xl hover:scale-105
    <div className='bg-blue-600 shadow-md sm:shadow-lg lg:shadow-2xl rounded-lg h-fit min-w-[350px] max-w-[350px]'>
      <div className='w-full'>
        <img src={imageUrl} alt={title} className='w-full rounded-lg'/>
      </div>
      <div className='px-2 py-3'>
        <div className='mb-3'>
        <div className='flex justify-between'>
          <div className='font-semibold'>{city}</div>
          <div className='flex items-center justify-center '>
            <FaStar className='mx-2 text-yellow-500'/>
            {rating}
          </div>
        </div>
        <div className='text-gray-300'>{country}</div>
        </div>
        <p className='text-gray-300 mb-2'>Size: {size}</p>
        <h2 className='font-semibold'>{amount}</h2>
      </div>

      
    </div>
  )
}

export default Card
