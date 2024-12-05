import { z } from "zod"
import { basicInfoSchema, locationDetailsSchema } from "./ServiceUploadSchema"
import { ReactNode } from "react"
import { useForm, useFieldArray } from 'react-hook-form'

type BasicInfoType = z.infer<typeof basicInfoSchema>
type LocationDetailsType = z.infer<typeof locationDetailsSchema>

type FormWrapper = {
    title: string,
    children: ReactNode,
    className?: string,
}

export const FormWrapper = ({title, children, className}: FormWrapper) => {
    return (
        <div className={"py-4"}>
            <h2 className="text-center mx-0 mb-8 font-semibold">{title}</h2>
            <div className={`mx-auto max-h-[50vh] overflow-y-auto ${className}`}>
                {children}
            </div>
        </div>
    )
}

export const BasicInfo = () => {
    return (
        <FormWrapper title="Basic Property Info" className="w-fit flex flex-col gap-5">
            <div className="">
                <label htmlFor="" className="block">Property Title</label>
                <span className="">
                    <input type="text" className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full"/>
                </span>
            </div>
            <div>
                <label htmlFor="">Property Description</label>
                <textarea name="Property description" id="" className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full min-h-8" 
                    placeholder="Enter your description"
                />
            </div>
            <div>
                <label htmlFor="" className="block">Property Type</label>
                <select name="Property Type" id="" className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full">
                    <option value="entire-home">Entire Home</option>
                    <option value="private-room">Private Room</option>
                    <option value="shared-room">Shared Room</option>
                </select>
            </div>
            <div>
                <label htmlFor="">Number of Bedrooms</label>
                <input type="text" className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full"/>
            </div>
        </FormWrapper>
    )
}

export const LocationDetails = () => {
    return (
        <FormWrapper title="Location Details" className="w-fit flex flex-col gap-5">
            <div>
                <label htmlFor="">Address</label>
                <input type="text" className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full" />
            </div>
            <div>
                <label htmlFor="">City</label>
                <input type="text" className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full" />
            </div>
            <div>
                <label htmlFor="">State/Province</label>
                <input type="text" className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full" />
            </div>
            <div>
                <label htmlFor="">Country</label>
                <input type="text" className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full" />
            </div>
            <div>
                <label htmlFor="">Neighborhood</label>
                <input type="text" className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full" />
            </div>
            <div>
                <label htmlFor="">GPS Coordinates</label>
                <input type="text" className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full"/>
            </div>
        </FormWrapper>
    )
}

export const PricingDetails = () => {
    return (
        <FormWrapper title="Amenities" className="flex flex-wrap w-fit gap-5 justify-between">
            <div className="w-2/5">
                <label htmlFor="">Kitchen</label>
                <select name="" id="" className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full">
                    <option value="yes">Yes</option>
                    <option value="no">No</option>
                </select>
            </div>
            <div className="w-2/5">
                <label htmlFor="">Living Room</label>
                <select name="" id="" className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full">
                    <option value="yes">Yes</option>
                    <option value="no">No</option>
                </select>
            </div>
            <div className="w-2/5">
                <label htmlFor="">Dining Area</label>
                <select name="" id="" className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full">
                    <option value="yes">Yes</option>
                    <option value="no">No</option>
                </select>
            </div>
            <div className="w-2/5">
                <label htmlFor="">Living Room</label>
                <select name="" id="" className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full">
                    <option value="yes">Yes</option>
                    <option value="no">No</option>
                </select>
            </div>
            <div className="w-2/5">
                <label htmlFor="">Wi-Fi</label>
                <select name="" id="" className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full">
                    <option value="yes">Yes</option>
                    <option value="no">No</option>
                </select>
            </div>
            <div className="w-2/5">
                <label htmlFor="">Air Conditioning</label>
                <select name="" id="" className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full">
                    <option value="yes">Yes</option>
                    <option value="no">No</option>
                </select>
            </div>
            <div className="w-2/5">
                <label htmlFor="">Heating</label>
                <select name="" id="" className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full">
                    <option value="yes">Yes</option>
                    <option value="no">No</option>
                </select>
            </div>
            <div className="w-2/5">
                <label htmlFor="">Parking</label>
                <select name="" id="" className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full">
                    <option value="yes">Yes</option>
                    <option value="no">No</option>
                </select>
            </div>
            <div className="w-2/5">
                <label htmlFor="">Pool</label>
                <select name="" id="" className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full">
                    <option value="yes">Yes</option>
                    <option value="no">No</option>
                </select>
            </div>
            <div className="w-2/5">
                <label htmlFor="">Gym</label>
                <select name="" id="" className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full">
                    <option value="yes">Yes</option>
                    <option value="no">No</option>
                </select>
            </div>
            <div className="w-2/5">
                <label htmlFor="">Laundry</label>
                <select name="" id="" className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full">
                    <option value="yes">Yes</option>
                    <option value="no">No</option>
                </select>
            </div>
        </FormWrapper>
    )
}

export const MediaUpload = () => {
    return (
        <FormWrapper title="Images and Videos">
            <div>

            </div>
        </FormWrapper>
    )
}

export const AdditionalInfo = () => {

    const { register, formState: {errors}, control, handleSubmit } = useForm({

    })

    const {} = useFieldArray({
        name: '', control, rules: {minLength: 2}
    })

    return (
        <FormWrapper title="Additional Info">
            <div>

            </div>
        </FormWrapper>
    )
}