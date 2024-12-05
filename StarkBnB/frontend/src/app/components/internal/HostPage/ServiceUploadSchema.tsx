import { z } from "zod";

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

export const formSchema = z.object({
    basicInfo: basicInfoSchema,
    locationDetails: locationDetailsSchema,
    amenities: dynamicFieldSchema,
    safetyAndSecurity: dynamicFieldSchema,
    additionalInfo: dynamicFieldSchema,
})