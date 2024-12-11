import { FaFireExtinguisher } from "react-icons/fa6";
import { infer, z } from "zod";

export const basicInfoSchema = z.object({
    propertyTitle: z.string().min(1, "Title is Required"),
    propertyDescription: z.string().min(10, 'Description should have at least 10 characters'),
    propertyType: z.enum(["Entire Home", "Private Room", "Shared Room"]),
    propertyPrice: z.number().min(1, "Price must be greater than 0"),
    currency: z.enum(["STRK"]),
});

export const locationDetailsSchema = z.object({
    address: z.string().min(1, 'Address is required'),
    city: z.string().min(1, 'City is required'),
    state: z.string().min(1, "State is required"),
    zip: z.string().min(1, "ZIP Code is required"),
    country: z.string().min(1, "Country is required"),
})

export const dynamicFieldSchema = z.array(
    z.object({
        name: z.string().min(1, "Field is Required")
    })
);

export const SecurityAndSeftySchema = z.object({
    address: z.string().min(1, 'Address is required'),
    smokeDetector: z.boolean(),
    CarbonDetector: z.boolean(),
    fireExtinguisher: z.boolean(),
    firstAidkit: z.boolean(),
    entrySystem: z.string().min(1, "Entry System Required"),
    surveillanceCam: z.string().min(1, "Response Required"),
    hostNumber: z.number().min(1, "Host Emergency number Required"),
    policeNumber: z.number().min(1, "Police Number Required"),
    fireNumber: z.number().min(1, "Fire Service Number Required"),
    hospitalPhone: z.number().min(1, "Hospital Emergency number Required"),

})

export const formSchema = z.object({
    basicInfo: basicInfoSchema,
    locationDetails: locationDetailsSchema,
    amenities: dynamicFieldSchema,
    safetyAndSecurity: SecurityAndSeftySchema,
    additionalInfo: dynamicFieldSchema,
})

export type formSchemaValues = z.infer<typeof formSchema>