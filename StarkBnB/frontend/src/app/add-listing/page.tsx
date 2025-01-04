import HostForm from "@/app/components/internal/HostPage/HostForm";


const WelcomeText = () => (
    <div className="text-black">
        <h1 className="text-5xl font-bold w-fit mx-auto capitalize py-3">
            Add Property for listing
        </h1>
        <div className="text-lg">
            <p>
                StarkBnB, built on Starknet ,provides users such as yourself opportunity to list your properties for rentals,
                controlled in a secure, escrow smart contract, while also:
            </p>
            <br />
            <ol className="ml-5">
                <li>Keeping your anonymity</li>
                <li>Securing your transaction with scalable, quantum-proof blockchain technology</li>
                <li>Providing you a user-controlled decentralized community</li>
            </ol>
            <br />
            <hr />
            <p className="text-center text-2xl font-semibold py-5 capitalize">
                Fill the form below to list property
            </p>
        </div>
    </div>
)

const HostProperty = () => {
    return ( 
        <div className="mx-auto w-4/5 mt-20 bg-white px-12 py-12 rounded-xl shadow-lg">
            <WelcomeText />
            <HostForm />
        </div>
     );
}
 
export default HostProperty;