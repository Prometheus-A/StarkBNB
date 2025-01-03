import React from 'react';
import Card from './Card';
import Link from 'next/link';


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
    <div className= 'w-full rounded-xl mx-auto flex flex-col gap-y-5'>
        <div className='w-10/12 mx-auto flex justify-between items-center'>
            <p>
                Latest Listings
            </p>
            <Link href={'listings'} className='border border-black py-1 px-1 rounded-lg hover:bg-black hover:text-white'>
                <p>
                    View All 
                </p>
            </Link>
        </div>
        <div className='flex flex-wrap w-10/12 justify-between mx-auto gap-y-12'>
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
        </div>
    </div>
  )
}

export default Properties
