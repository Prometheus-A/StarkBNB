'use client'

import useMultiStepForm from "../hooks/useMultiStepForm";
import { FormProvider, SubmitHandler, useForm } from 'react-hook-form'
import { AdditionalInfo, BasicInfo, LocationDetails, MediaUpload, PricingDetails, SecurityAndSafety } from "./Parts";
import {formSchema, formSchemaValues} from './ServiceUploadSchema'
import { zodResolver } from "@hookform/resolvers/zod";

const HostForm = () => {

    const {
        steps, currentStepIndex, step, isFirstStep, isLastStep, back, next
    } = useMultiStepForm([
        <BasicInfo />,
        <LocationDetails />,
        <PricingDetails />,
        <MediaUpload />,
        <SecurityAndSafety/>,
        <AdditionalInfo />
    ])

    const onSubmit: SubmitHandler<formSchemaValues> = data => {
        alert("Hey dear")
        console.log(data);
    }

    const methods = useForm<formSchemaValues>({
        resolver: zodResolver(formSchema),
    })

    const {handleSubmit} = methods

    return ( 
        <div className="relative bg-white mt-4 mx-auto px-8 w-[45%] rounded-xl shadow-md">
            <FormProvider {...methods}>
            <form action="" className="flex flex-col gap-5" onSubmit={handleSubmit(onSubmit)}>
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
                    }}
                    // type={isLastStep ? "submit" : "button"}
                    >
                        {!isLastStep ? "Next" : "Submit"}
                    </button>
                </div>
            </form>
            </FormProvider>
        </div>
    );
}
 
export default HostForm;