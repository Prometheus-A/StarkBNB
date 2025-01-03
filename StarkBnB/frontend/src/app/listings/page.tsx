import Link from "next/link";
import Properties from "../components/internal/HomePage/Properties";

const HostPage = () => {
    return ( 
        <div className="w-fit flex flex-col items-center justify-center gap-5 mx-auto mt-[10%]">
            {/* This div is for the search bar and the filter and sort actions */}
            <div>

            </div>

            {/* This div is for the listings */}
            <div className="bg-white rounded-lg w-[85%] px-6 py-4 mx-auto shadow">
                <Properties />
            </div>
        </div>
     );
}
 
export default HostPage;