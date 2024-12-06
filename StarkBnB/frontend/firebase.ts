// Import the functions you need from the SDKs you need
import { initializeApp, getApp, getApps } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import 'firebase/firestore'
import { collection, doc, getDoc, getDocs, getFirestore, query, setDoc, updateDoc, where } from 'firebase/firestore'
import { getStorage } from 'firebase/storage'
import { T } from "node_modules/@starknet-react/core/dist/index-79NvzQC9";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: process.env.NEXT_PUBLIC_FIREBASE_API_KEY,
  authDomain: process.env.NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN,
  projectId: process.env.NEXT_PUBLIC_FIREBASE_PROJECT_ID,
  storageBucket: process.env.NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET,
  messagingSenderId: process.env.NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID,
  appId: process.env.NEXT_PUBLIC_FIREBASE_APP_ID,
  measurementId: process.env.NEXT_PUBLIC_FIREBASE_MEASUREMENT_ID
};

// Initialize Firebase
const app = !getApps.length ? initializeApp(firebaseConfig) : getApp();
const analytics = getAnalytics(app);

export const db = getFirestore(app)

const getUser = async (address: string) => {
  const q = query(collection(db, 'Users'), where('walletAddress', '==', address));
  const querySnapShot = await getDocs(q)
  
  if (querySnapShot.empty) return

  const user = querySnapShot?.docs?.[0]
  const userId = user.id
  const userData = user.data()

  return { userId, userData }
}

const handleBookingHistory = async (address: string, values: Record<any, T>) => {
  const user = await getUser(address)

  if (!user) return
  const userId = user?.userId
  const userDocRef = doc(db, 'users', userId)

  try {
    const userDoc = await getDoc(userDocRef)
    if (userDoc.exists()) {
      await updateDoc(userDocRef, {

      })
    } else {
      await setDoc(userDocRef, {

      })
    }
  } catch (err) {

  }

  // const userBookingHistory = userData?.userActivity?.userBookingHistory

  


}

const handleReviews = async () => {}

// Properties Functions

const addToProperties = async () => {}

const updateProperty = async () => {}

const deleteProperty = async () => {}

const handlePropertyOpenStatus = async () => {}

const transferPropertyOwnership = async () => {}

const getProperties = async () => {}

const getPropertyById = async () => {}