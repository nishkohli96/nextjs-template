'use client';

import { Roboto } from 'next/font/google';
import { type PaletteMode } from '@mui/material/styles';
import { LightThemePalette, DarkThemePalette } from './palette';

const roboto = Roboto({
  weight: [
    '300',
    '400',
    '500',
    '700'
  ],
  subsets: ['latin'],
  display: 'swap',
  variable: '--font-roboto'
});

export const getTheme = (mode: PaletteMode) => ({
  palette: {
    mode,
    common: {
      black: '#000',
      white: '#fff',
    },
    ...(mode === 'light' ? LightThemePalette : DarkThemePalette),
  },
  breakpoints: {
    values: {
      xs: 0,
      sm: 350,
      md: 768,
      lg: 1024,
      xl: 1400,
    },
  },
  typography: {
    fontFamily: roboto.style.fontFamily,
  },
});
