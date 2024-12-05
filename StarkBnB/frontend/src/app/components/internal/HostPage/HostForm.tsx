'use client'

import useMultiStepForm from "../hooks/useMultiStepForm";
import { AdditionalInfo, BasicInfo, LocationDetails, MediaUpload, PricingDetails } from "./Parts";

const HostForm = () => {

    const {
        steps, currentStepIndex, step, isFirstStep, isLastStep, back, next
    } = useMultiStepForm([
        <BasicInfo />,
        <LocationDetails />,
        <PricingDetails />,
        <MediaUpload />,
        <AdditionalInfo />
    ])

    return ( 
        <div className="relative bg-white mt-4 mx-auto px-8 w-[45%] rounded-xl shadow-md">
            <form action="" className="flex flex-col gap-5">
                <div className="top-2 right-2 absolute">
                    {currentStepIndex + 1} / {steps.length}
                </div>
                {step}
                <div className="mt-4 flex gap-2 justify-end">
                    {/* {!isFirstStep && (<button type="button" onClick={back}>Back</button>)}
                    <button type='submit' onClick={() => {
                        next
                    }}>
                        {isLastStep ? 'Finish':'Next'}
                    </button> */}
                    {!isFirstStep && (
                        <button onClick={(e) => {
                            e.preventDefault()
                            back()
                        }}>
                            Back
                        </button>
                    )}
                    <button onClick={(e) => {
                        e.preventDefault()
                        next()
                    }}>
                        {!isLastStep ? "Next" : "Submit"}
                    </button>
                </div>
            </form>
        </div>
    );
}
 
export default HostForm;