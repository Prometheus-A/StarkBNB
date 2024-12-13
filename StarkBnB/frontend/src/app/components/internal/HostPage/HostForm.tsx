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
        <div className="relative mt-4 mx-auto px-8 w-full bg-[#f2f2f2] rounded-xl shadow-md text-base py-4">
            <FormProvider {...methods}>
                <form action="" className="flex flex-col justify-between" onSubmit={handleSubmit(onSubmit)}>
                    <div className="top-2 right-2 absolute bg-white rounded-md px-2 py-1 font-bold">
                        {currentStepIndex + 1} / {steps.length}
                    </div>
                    {step}
                    <div className="mt-4 flex gap-2 justify-end">
                        {!isFirstStep && (
                            <button className="px-4 py-2 rounded-md font-bold bg-red-600 text-white"
                                onClick={(e) => {
                                e.preventDefault()
                                back()
                            }}>
                                Previous
                            </button>
                        )}
                        <button type="submit"
                            className={`${isLastStep ? 'bg-blue-600 text-white':'bg-white text-black'} shadow-lg px-4 py-2 rounded-md font-bold`}
                            onClick={(e) => {
                                e.preventDefault()
                                next()
                        }}>
                            {!isLastStep ? "Next" : "Submit"}
                        </button>
                    </div>
                </form>
            </FormProvider>
        </div>
    );
}
 
export default HostForm;