{-# LANGUAGE OverloadedStrings #-}

module RenderGeometry where

import Control.Monad
import Data.Word (Word8)
import Foreign (castPtr, plusPtr, sizeOf)
import Foreign.C.Types
import SDL.Vect
import qualified Data.Vector.Storable as V

import SDL (($=))
import qualified SDL
import SDL.Raw.Types (FPoint(..), Color(..))

screenWidth, screenHeight :: CInt
(screenWidth, screenHeight) = (640, 480)

main :: IO ()
main = do
  SDL.initialize [SDL.InitVideo]
  SDL.HintRenderScaleQuality $= SDL.ScaleLinear
  do renderQuality <- SDL.get SDL.HintRenderScaleQuality
     when (renderQuality /= SDL.ScaleLinear) $
       putStrLn "Warning: Linear texture filtering not enabled!"

  window <-
    SDL.createWindow
      "SDL / RenderGeometry Example"
      SDL.defaultWindow
        { SDL.windowInitialSize = V2 screenWidth screenHeight
        , SDL.windowGraphicsContext = SDL.OpenGLContext SDL.defaultOpenGL
        }
  SDL.showWindow window

  renderer <- SDL.createRenderer window (-1) SDL.defaultRenderer

  let
    tl = fromIntegral screenWidth * 0.1
    tt = fromIntegral screenHeight * 0.1
    tr = fromIntegral screenWidth * 0.9
    tb = fromIntegral screenHeight * 0.9

    triVertices = V.fromList
      [ SDL.Vertex
          (FPoint tl tb)
          (Color 0xFF 0 0 255)
          (FPoint 0 0)
      , SDL.Vertex
          (FPoint tr tb)
          (Color 0 0xFF 0 255)
          (FPoint 0 1)
      , SDL.Vertex
          (FPoint (tl/2 + tr/2) tt)
          (Color 0 0 0xFF 255)
          (FPoint 1 1)
      ]

  let
    l = fromIntegral screenWidth * 0.2
    t = fromIntegral screenHeight * 0.2
    r = fromIntegral screenWidth * 0.8
    b = fromIntegral screenHeight * 0.8

    quadVertices = V.fromList
      [ SDL.Vertex
          (FPoint l b)
          (Color 0xFF 0 0xFF 127)
          (FPoint 0 0)
      , SDL.Vertex
          (FPoint r b)
          (Color 0xFF 0 0xFF 127)
          (FPoint 1 0)
      , SDL.Vertex
          (FPoint r t)
          (Color 0xFF 0xFF 0 127)
          (FPoint 1 1)
      , SDL.Vertex
          (FPoint l t)
          (Color 0 0 0 127)
          (FPoint 0 1)
      ]
    quadIndices = V.fromList
      [ 0, 1, 3
      , 2, 3, 1
      ]
    stride = fromIntegral $ sizeOf (undefined :: SDL.Vertex)

  let loop = do
        events <- SDL.pollEvents
        let quit = elem SDL.QuitEvent $ map SDL.eventPayload events

        SDL.rendererDrawColor renderer $= V4 maxBound maxBound maxBound maxBound
        SDL.clear renderer

        SDL.renderGeometry
          renderer
          Nothing
          triVertices
          mempty

        SDL.rendererDrawBlendMode renderer $= SDL.BlendAlphaBlend
        V.unsafeWith quadVertices $ \ptr ->
          SDL.renderGeometryRaw
            renderer
            Nothing
            (castPtr ptr)
            stride
            (castPtr ptr `plusPtr` sizeOf (undefined :: FPoint))
            stride
            (castPtr ptr `plusPtr` sizeOf (undefined :: FPoint) `plusPtr` sizeOf (undefined :: Color))
            stride
            (fromIntegral $ V.length quadVertices)
            (quadIndices :: V.Vector Word8)

        SDL.present renderer

        unless quit loop

  loop

  SDL.destroyWindow window
  SDL.quit
