import Link from 'next/link'

export default function Navbar() {
    return <header className='bg-gray-500 w-full h-12 flex items-center'>
      <Link href={'/'} className='px-2 font-bold'>
        Demo website
      </Link>
    </header>
  }