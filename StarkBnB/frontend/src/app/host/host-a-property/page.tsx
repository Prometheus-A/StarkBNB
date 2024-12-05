import HostForm from "@/app/components/internal/HostPage/HostForm";

const WelcomeText = () => (
    <div>
        <h1 className="text-xl font-bold">
            Add a Property for listing!!!
        </h1>
        <p>
            This is going to be welcome text for those trying to host a house for the first time.
            <br />
            StarkBnB takes advantage of Blockchain Technology and builds on Starknet (and other chains soon)
            to serve our users a web app where they can put up their property for rentals, but anonymously.
            <br />
            We address the privacy breaches that are common with web 2 by taking advantage of Starknet, as it
            aligns with the goal of the organization behind us - Prometheus.
            <br />
            More will be added/removed from this text to make it better later
        </p>
    </div>
)

const HostProperty = () => {
    return ( 
        <div className="mx-auto w-4/5">
            <WelcomeText />
            <HostForm />
        </div>
     );
}
 
export default HostProperty;