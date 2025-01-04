import Link from "next/link";
import Properties from "../components/internal/HomePage/Properties";
import { CiSearch } from "react-icons/ci";
import { MdOutlineSort } from "react-icons/md";

const HostPage = () => {
    return ( 
        <div className="w-fit flex flex-col items-center justify-center gap-5 mx-auto mt-[3%]">
            {/* This div is for the search bar and the filter and sort actions */}
            <div className="border-[#777] border-2 rounded-xl flex justify-start items-center gap-x-6 w-2/5 bg-white px-3 py-1">
                <CiSearch className="w-fit"/>
                <input type="text" placeholder="Search" className="outline-none w-[300px] h-[50px]" />
                <MdOutlineSort />
            </div>
            <p>This will be replaced with a search bar for sorting, searching and a whole lof of mechanisms when the UI/UX guy is done</p>

            {/* This div is for the listings */}
            <div className="bg-white rounded-lg w-[85%] px-6 py-4 mx-auto shadow">
                <Properties />
            </div>
        </div>
     );
}
 
export default HostPage;