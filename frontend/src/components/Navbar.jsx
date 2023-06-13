import Link from 'next/link'

export default function Navbar() {
    return       <header className="bg-blue-500 py-4">
        <nav className="container mx-auto flex items-center justify-between">
          <a href="#" className="text-white font-semibold text-2xl">
           Demo webpage
          </a>
          <ul className="flex space-x-4">
            <li>
              <a href="#" className="text-white hover:text-gray-200">Home</a>
            </li>
            <li>
              <a href="#" className="text-white hover:text-gray-200">About</a>
            </li>
            <li>
              <a href="#" className="text-white hover:text-gray-200">Contact</a>
            </li>
          </ul>
        </nav>
      </header>
  }