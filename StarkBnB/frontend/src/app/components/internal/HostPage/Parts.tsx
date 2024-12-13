import { z } from "zod"
import { basicInfoSchema, locationDetailsSchema, formSchemaValues } from "./ServiceUploadSchema"
import { ReactNode } from "react"
import { useForm, useFieldArray, useFormContext } from 'react-hook-form'

type FormWrapper = {
    title: string,
    children: ReactNode,
    className?: string,
}

export const FormWrapper = ({title, children, className}: FormWrapper) => {
    return (
        <div className={"py-8 text-black"}>
            <h2 className="text-center mx-0 mb-8 font-semibold text-gray-700">{title}</h2>
            <div className={`mx-auto h-[50vh] overflow-y-auto ${className}`}>
                {children}
            </div>
        </div>
    )
}

export const BasicInfo = () => {
    return (
        <FormWrapper title="Basic Property Info" className="w-full flex flex-col gap-5">
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
        <FormWrapper title="Location Details" className="w-full flex flex-col gap-5">
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

export const SecurityAndSafety = () => {

     const { 
        register,
        formState: {errors}
     } = useFormContext<formSchemaValues>();
      
    
    return (
        <FormWrapper title="Safety and Security" className="w-fit flex flex-col gap-5">
            {/* Safety Features */}
            <div className="flex flex-wrap gap-4">
                <div className="w-1/3">
                    
                    <label htmlFor="smokeDetectors" className="block">
                        Smoke Detectors:
                    </label>
                    <input
                        {...register("safetyAndSecurity.smokeDetector")}
                        type="checkbox"
                        id="smokeDetectors"
                        className="mt-2"
                    />
                </div>
                <div className="w-1/3">
                    <label htmlFor="carbonMonoxideDetectors" className="block">
                        Carbon Monoxide Detectors:
                    </label>
                    <input
                        {...register("safetyAndSecurity.CarbonDetector")}
                        type="checkbox"
                        id="carbonMonoxideDetectors"
                        className="mt-2"
                    />
                </div>
                <div className="w-1/3">
                    <label htmlFor="fireExtinguishers" className="block">
                        Fire Extinguishers:
                    </label>
                    <input
                        {...register("safetyAndSecurity.fireExtinguisher")}
                        type="checkbox"
                        id="fireExtinguishers"
                        className="mt-2"
                    />
                </div>
                <div className="w-1/3">
                    <label htmlFor="firstAidKit" className="block">
                        First Aid Kit:
                    </label>
                    <input
                        {...register("safetyAndSecurity.firstAidkit")}
                        type="checkbox"
                        id="firstAidKit"
                        className="mt-2"
                    />
                    {errors.safetyAndSecurity?.firstAidkit && <p>{errors.safetyAndSecurity?.firstAidkit.message}</p>}
                </div>
            </div>

            {/* Entry System */}
            <div>
                <label htmlFor="entrySystem" className="block">
                    Entry System:
                </label>
                <select
                    {...register("safetyAndSecurity.entrySystem")}
                    id="entrySystem"
                    className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full"
                >
                    <option value="key">Key</option>
                    <option value="keypad">Keypad</option>
                    <option value="smartLock">Smart Lock</option>
                    <option value="doorman">Doorman</option>
                    <option value="securityGuard">Security Guard</option>
                </select>
                {errors.safetyAndSecurity?.message && <p>{String(errors.safetyAndSecurity.message)}</p>}
            </div>

            {/* Surveillance Cameras */}
            <div>
                <label htmlFor="surveillanceCameras" className="block">
                    Surveillance Cameras:
                </label>
                <select
                    {...register("safetyAndSecurity.surveillanceCam")}
                    id="surveillanceCameras"
                    className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full"
                >
                    <option value="yes">Yes</option>
                    <option value="no">No</option>
                </select>
                {errors.safetyAndSecurity?.surveillanceCam && <p>{String(errors.safetyAndSecurity.surveillanceCam.message)}</p>}
            </div>

            {/* Emergency Contacts */}
            <div className="flex flex-col gap-4">
                <h3 className="text-lg font-medium">Emergency Contacts</h3>
                <div>
                    <label htmlFor="hostPhone" className="block">
                        Host Phone:
                    </label>
                    <input
                        {...register("safetyAndSecurity.hostNumber")}
                        type="text"
                        id="hostPhone"
                        placeholder="Enter phone number"
                        className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full"
                    />
                    {errors.safetyAndSecurity?.hostNumber && <p>{errors.safetyAndSecurity.hostNumber.message}</p>}
                </div>
                <div>
                    <label htmlFor="hospitalPhone" className="block">
                        Hospital Phone:
                    </label>
                    <input
                        {...register("safetyAndSecurity.hospitalPhone")}
                        type="text"
                        id="hospitalPhone"
                        placeholder="Enter hospital contact"
                        className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full"
                    />
                    {errors.safetyAndSecurity?.hospitalPhone && <p>{errors.safetyAndSecurity.hospitalPhone?.message}</p>}
                </div>
                <div>
                    <label htmlFor="policeNumber" className="block">
                        Police Number:
                    </label>
                    <input
                        {...register("safetyAndSecurity.policeNumber")}
                        type="text"
                        id="policeNumber"
                        placeholder="Enter police contact"
                        className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full"
                    />
                    {errors.safetyAndSecurity?.policeNumber && <p>{errors.safetyAndSecurity.policeNumber?.message}</p>}
                </div>
                <div>
                    <label htmlFor="fireNumber" className="block">
                        Fire Number:
                    </label>
                    <input
                        {...register("safetyAndSecurity.fireNumber")}
                        type="text"
                        id="fireNumber"
                        placeholder="Enter fire service contact"
                        className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full"
                    />
                    {errors.safetyAndSecurity?.fireNumber && <p>{errors.safetyAndSecurity.fireNumber?.message}</p>}
                </div>
            </div>

            {/* Additional Information */}
            <div>
                <label htmlFor="additionalInfo" className="block">
                    Additional Safety Instructions:
                </label>
                <textarea
                    id="additionalInfo"
                    placeholder="Enter additional safety details, e.g., evacuation routes."
                    className="outline-none rounded-lg border border-gray-300 px-4 py-2 w-full min-h-[80px]"
                />
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