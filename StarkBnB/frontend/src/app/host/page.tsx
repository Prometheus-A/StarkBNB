import Link from "next/link";

const HostPage = () => {
    return ( 
        <div className="w-fit flex flex-col items-center justify-center gap-5 mx-auto mt-[10%]">
            <p>Nothing else will be in this page for now, List a Property below to see stuff</p>
            <button className="bg-blue-500 text-white rounded-md mx-auto w-fit px-4 py-2">
                <Link href={'/host/host-a-property'}>
                    List A Property
                </Link>
            </button>
        </div>
     );
}
 
export default HostPage;