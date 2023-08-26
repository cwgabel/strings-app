'use client'
import React, { FormEvent, useState } from 'react'

export default function Form() {
    const [username, setUsername] = useState<undefined | string>('')
    const [password, setPassword] = useState<undefined | string>('')
    const [confirmPassword, setConfirmPassword] = useState<
        undefined | string
    >('')

    const [errors, setErrors] = useState<string[]>([])

    async function handleSubmit(e: FormEvent) {
        e.preventDefault()
        setErrors([])

        if (password !== confirmPassword) {
            const newErrors = []
            newErrors.push('Passwords do not match')
            setErrors(newErrors)
            return
        }

        const res = await fetch('/api/signup', {
            method: 'post',
            body: JSON.stringify({ username, password }),
        })
        if (res.ok) {
            window.location.href = '/signin'
        } else {
            alert('sign up failed')
        }
    }

    return (
        <form
            onSubmit={handleSubmit}
            className='flex flex-col gap-2 p-5 max-w-xs w-full bg-slate-800 rounded-lg'
        >
            <div className='text-center'>
                <h3 className='font-semibold'>Sign Up</h3>
            </div>
            <div className='my-3'>
                <hr />
            </div>
            <div>
                <div className='flex flex-col gap-3'>
                    <label>Username</label>
                    <input
                        type='text'
                        className='text-black p-3 border border-slate-700 rounded-lg'
                        onChange={(e) => setUsername(e.target.value)}
                        value={username}
                        id='username'
                        placeholder='Username'
                        required
                    />
                </div>
            </div>
            <div className='flex flex-col gap-3'>
                <label>Password</label>
                <input
                    type='password'
                    className='text-black p-3 border border-slate-700 rounded-lg'
                    onChange={(e) => setPassword(e.target.value)}
                    value={password}
                    id='password'
                    autoComplete="false"
                    placeholder='Password'
                    required
                />
            </div>
            <div className='flex flex-col gap-3'>
                <label>Confirm Password</label>
                <input
                    type='password'
                    className='text-black p-3 border border-slate-700 rounded-lg'
                    onChange={(e) => setConfirmPassword(e.target.value)}
                    value={confirmPassword}
                    id='confirm-password'
                    placeholder='Confirm Password'
                    required
                />
            </div>
            <button
                type='submit'
                className='mt-4 bg-slate-900 text-white p-3 rounded-lg'
            >
                Sign Up
            </button>
            {errors.map((error) => {
                return (
                    <div key={error} className='text-red-600'>
                        {error}
                    </div>
                )
            })}
        </form>
    )
}
