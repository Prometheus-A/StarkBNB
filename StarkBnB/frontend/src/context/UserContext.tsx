'use client'

import { db } from "../../firebase"
import { addDoc, collection, DocumentData, getDoc, getDocs, query, where } from "firebase/firestore"
import { encode, decode } from 'base64-arraybuffer'
import Cookies from 'universal-cookie'

import React, { createContext, Dispatch, SetStateAction, useContext, useEffect, useState } from "react"

type User = {
    walletAddress: string
} | null

type UserContextType = {
    currentUser: User,
    userDataObj: DocumentData | null,
    setCurrentUser: Dispatch<SetStateAction<User>>;
    setUserDataObj: React.Dispatch<React.SetStateAction<Record<string, any>>>;
    getUser: (walletAddress: string) => void;
    createToken: (walletAddress: string) => void;
    getToken: (token: string) => {walletAddress: string, timestamp: number} | null
} | null


const UserContext = createContext<UserContextType>(null)

const cookie = new Cookies()

export const useUser = () => {
    const context = useContext(UserContext)

    if (!context) {
        throw new Error('useUser must be used within a UserProvider')
    }

    return context
}

export const UserProvider: React.FC<{children: React.ReactNode}> = ({children}) => {

    const [currentUser, setCurrentUser] = useState<User>(null)
    const [userDataObj, setUserDataObj] = useState<DocumentData | {}>({})
    const [loading, setLoading] = useState(false)

    const getUser = async (walletAddress: string) => {
        const q = query(collection(db, 'Users'), where('walletAddress', '==', walletAddress));
        const querySnapShot = await getDocs(q)

        if (querySnapShot.empty) {
            const docRef = await addDoc(collection(db, 'Users'), {
                walletAddress,
            })
            const docSnap = await getDoc(docRef);
            setUserDataObj(docSnap.data()!)
            setCurrentUser({walletAddress})
        } else if (!querySnapShot.empty && querySnapShot.size == 1) {
            setUserDataObj(querySnapShot?.docs?.[0]?.data())
            setCurrentUser({walletAddress})
        } else {
            throw new Error('This user cannot have more than one account')
        }
    }

    const createToken = (walletAddress: string) => {
        const timestamp = Date.now().toString();
        const data = `${walletAddress}:${timestamp}`
        const encodedData = encode(new TextEncoder().encode(data));
        // const encodedTimestamp = encode(new TextEncoder().encode(timestamp))
        const expirationTime = Date.now() + (3 * 60 * 60 * 1000)
        const expires = new Date(expirationTime)
        cookie.set("sessionToken", encodedData, {
            httpOnly: true,
            path: "/",
            secure: true,
            sameSite: 'strict',
            expires
        })
    }

    const getToken = (token: string): { walletAddress: string; timestamp: number } | null => {
        try {
            const decodedBuffer = decode(token)
            const decodedData = new TextDecoder().decode(decodedBuffer)

            const [walletAddress, timestamp] = decodedData.split(":")

            return {
                walletAddress, timestamp: parseInt(timestamp, 10)
            }
        } catch (err) {
            console.error('Failed to find token', err)
            return null
        }
    }

    const value = {
        currentUser, userDataObj, setUserDataObj, getUser, createToken, getToken, setCurrentUser
    }

    return (
        <UserContext.Provider value={value}>
            {children}
        </UserContext.Provider>
    )
}