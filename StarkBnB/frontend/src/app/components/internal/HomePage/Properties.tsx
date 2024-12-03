import React from 'react';
import Card from './Card';


const Properties = () => {
  const cards = [
    {
        title: 'image',
        imageUrl: '/images/bg.png',
        rating: '5.0',
        city: "Okpanam, Asaba",
        country: 'Nigeria',
        size: '2,500 sq ft',
        amount: '2.5 ETH / Month',
    },
    {
        title: 'image',
        imageUrl: '/images/bg.png',
        rating: '5.0',
        city: "Okpanam, Asaba",
        country: 'Nigeria',
        size: '2,500 sq ft',
        amount: '2.5 ETH / Month',
    },
    {
        title: 'image',
        imageUrl: '/images/bg.png',
        rating: '5.0',
        city: "Okpanam, Asaba",
        country: 'Nigeria',
        size: '2,500 sq ft',
        amount: '2.5 ETH / Month',
    },
    {
        title: 'image',
        imageUrl: '/images/bg.png',
        rating: '5.0',
        city: "Okpanam, Asaba",
        country: 'Nigeria',
        size: '2,500 sq ft',
        amount: '2.5 ETH / Month',
    },
    {
        title: 'image',
        imageUrl: '/images/bg.png',
        rating: '5.0',
        city: "Okpanam, Asaba",
        country: 'Nigeria',
        size: '2,500 sq ft',
        amount: '2.5 ETH / Month',
    },
    {
        title: 'image',
        imageUrl: '/images/bg.png',
        rating: '5.0',
        city: "Okpanam, Asaba",
        country: 'Nigeria',
        size: '2,500 sq ft',
        amount: '2.5 ETH / Month',
    },
  ];

  return (
    <div className='bg-white rounded-xl w-9/12 mx-auto flex flex-col gap-5'>
        <div>
            <p>
                Latest Listings
            </p>
        </div>
        <div className='flex flex-wrap items-center justify-between gap-x-5 gap-y-16 mx-auto w-full'>
        {
            cards.map((card, index) => (
            <Card
            key={index}
            title= {card.title}
            imageUrl= {card.imageUrl}
            rating= {card.rating}
            city= {card.city}
            country= {card.country}
            size= {card.size}
            amount= {card.amount}
            /> 
            ))
        }
        {/* <Card
            title= 'image'
            imageUrl= '/images/bg.png'
            rating= '5.0'
            city= "Okpanam, Asaba"
            country= 'Nigeria'
            size= '2,500 sq ft'
            amount= '2.5 ETH / Month'
        /> */}

        </div>
    </div>
  )
}

export default Properties
