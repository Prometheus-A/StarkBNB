export const HeroSection = () => {
  return (
    <div>
        <div 
            className='flex flex-col gap-3 h-[40rem] bg-main-page bg-cover justify-center items-center'
            >
            <div className='flex flex-col gap-10 text-white text-center mx-auto w-fit'>
                <div className='flex flex-col gap-4'>
                    <p className='font-semibold uppercase text-xl'>A place to call home</p>
                    <p className='font-bold capitalize text-6xl'>Rent your dream vacation spot</p>
                    <p className='font-semibold text-xl w-3/4 mx-auto'>
                        Discover the perfect home away from home, with Starknet technology to help secure your transaction.
                    </p>
                </div>
                <div className='mx-auto w-fit'>
                    <button className="flex items-center justify-center gap-2 px-6 py-3 text-md bg-black text-white rounded font-bold">
                        Recent Listings
                    </button>
                </div>
            </div>
        </div>
        <div className='flex w-fit mx-auto my-20 bg-white py-9 rounded-xl shadow'>
            <div className='flex flex-col justify-center items-center w-60 h-fit border-r border-gray-400'>
                <p className='font-semibold text-3xl'>136</p>
                <p className='text-base'>Houses</p>
            </div>
            <div className='flex flex-col justify-center items-center w-60 h-fit border-r border-gray-400'>
                <p className='font-semibold text-3xl'>79</p>
                <p className='text-base'>Apartments</p>
            </div>
            <div className='flex flex-col justify-center items-center w-60 h-fit border-r border-gray-400'>
                <p className='font-semibold text-3xl'>843</p>
                <p className='text-base'>Satisfied Guests</p>
            </div>
            <div className='flex flex-col justify-center items-center w-60 h-fit'>
                <p className='font-semibold text-3xl'>265</p>
                <p className='text-base'>Happy Owners</p>
            </div>
        </div>
    </div>
)
}
