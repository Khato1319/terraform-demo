import Head from 'next/head'

import { API_KEY } from "src/constants";

export default function Home() {
    return (
    <div className="bg-gray-100 w-full h-auto flex flex-col">

      <main className="flex-1 container mx-auto py-16">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-8 items-center">
          <div>
            <h1 className="text-4xl md:text-6xl font-semibold text-gray-800 mb-4">
              Demo webpage
            </h1>
            <p className="text-lg md:text-xl text-gray-600 mb-8">
              This is the home page of our modern and fresh-looking demo website deployed in AWS with the help of Terraform.
            </p>
            <a href="#" className="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md font-medium">
              Get Started
            </a>
          </div>
          <div className="md:order-first">
            <img src="https://www.svgrepo.com/show/376353/terraform.svg" alt="Demo Image" className="rounded-lg shadow-lg" />
          </div>
        </div>
      </main>
      <footer className="bg-blue-500 py-4 mt-auto">
        <p className="text-center text-white">
          &copy; 2023 My Demo App. All rights reserved.
        </p>
      </footer>
    </div>
  );
}
