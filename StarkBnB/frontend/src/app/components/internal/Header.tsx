"use client";
import { useEffect, useMemo, useRef, useState } from "react";
import { useAccount } from "@starknet-react/core";
import AddressBar from "../lib/AddressBar";
import ThemeSwitch from "./util/ThemeSwitch";
import ConnectButton from "../lib/Connect";
import useTheme from "@/app/components/internal/hooks/useTheme";
import Link from "next/link";
import MenuButton from "./MenuButton";
import { useUser } from "@/context/UserContext";
import Image from "next/image";
import STARKBNB from '../../../../public/custom/starkbnb.png'

const Header = () => {
  const { address } = useAccount();
  const { theme, changeTheme } = useTheme();
  const lastYRef = useRef(0);
  const { getUser, createToken } = useUser()
  const [walletAddress, setWalletAddress] = useState<string | undefined>()

  const userCheck = useMemo(() => {
    if (!walletAddress) return
    setWalletAddress(address)
    getUser(walletAddress)
    createToken(walletAddress)
    console.log('Get user successful')
  }, [address, walletAddress])

  useEffect(() => {
    const nav = document.getElementById("nav");
    const handleScroll = () => {
      const difference = window.scrollY - lastYRef.current;
      if (Math.abs(difference) > 50) {
        if (difference > 0) {
          nav?.setAttribute("data-header", "scroll-hide");
        } else {
          nav?.setAttribute("data-header", "scroll-show");
        }
        lastYRef.current = window.scrollY;
      }
    };
    window.addEventListener("scroll", handleScroll);

    return () => {
      window.removeEventListener("scroll", handleScroll);
    };
  }, []);

  return (
    <div
      onFocusCapture={(e) =>
        e.currentTarget.setAttribute("data-header", "scroll-show")
      }
      id="nav"
      className="w-full transition-all duration-500 border-b bg-white"
    >
      <header className="rounded-[12px] md:rounded-[32px]">
        <div className="mx-auto flex h-16 max-w-[--header-max-w] items-center justify-between px-4 md:h-28 md:px-8">
          <div className="hidden md:block px-12">
            <div className="">
              <Link href={"/"}>
                <Image 
                  src={STARKBNB}
                  alt="StarkBnB"
                  width={100}
                  height={100}
                  style={{
                    filter: 'none',
                    backgroundColor: 'black'
                  }}
                />
              </Link>
            </div>
          </div>

          <Link href={"/"} className="block h-[35px] w-[35px] md:hidden">
            <img src="/custom/bird-logo.png" alt="" />
          </Link>

          <div className="flex justify-center items-center text-black gap-5">
            <Link href={'/add-listing'}>
              <button className="border border-black px-6 py-3 text-sm rounded-[12px] md:py-4">
                Become a Host
              </button>
            </Link>
            <div className="">
              {address ? (
                <div className="flex items-center gap-4">
                  <AddressBar />
                  <MenuButton />
                </div>
              ) : (
                <ConnectButton />
              )}
              {/* <ThemeSwitch
                className="absolute bottom-[-200%] left-3/4 md:grid lg:bottom-[-250%] lg:left-1/2"
                action={changeTheme}
                theme={theme}
              /> */}
            </div>
          </div>
        </div>
      </header>
    </div>
  );
};

export default Header;
