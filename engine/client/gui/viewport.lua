--=========== Copyright © 2019, Planimeter, All rights reserved. ===========--
--
-- Purpose: Viewport Panel class
--
--==========================================================================--

class "gui.viewport" ( "gui.box" )

local viewport = gui.viewport

function viewport:viewport( parent )
	gui.box.box( self, parent, "Viewport" )
	self.width  = love.graphics.getWidth()
	self.height = love.graphics.getHeight()
	self:setUseFullscreenCanvas( true )
	self:moveToBack()
end

function viewport:invalidateLayout()
	self:setDimensions( love.graphics.getWidth(), love.graphics.getHeight() )

	gui.panel.invalidateLayout( self )
end

local VIEWPORT_ANIM_TIME = 0.2

function viewport:hide()
	self:animate( {
		opacity = 0,
	}, VIEWPORT_ANIM_TIME, "easeOutQuint", function()
		self:setVisible( false )
		self:setOpacity( 1 )
	end )
end

function viewport:show()
	if ( not self:isVisible() ) then
		self:setOpacity( 0 )
		self:animate( {
			opacity = 1
		}, VIEWPORT_ANIM_TIME, "easeOutQuint" )
	end

	self:setVisible( true )
end

local function hideViewport()
	if ( g_Viewport == nil ) then
		return
	end

	g_Viewport:hide()
end

hook.set( "client", hideViewport, "onMainMenuActivate", "hideViewport" )

local function showViewport()
	if ( g_Viewport == nil ) then
		return
	end

	g_Viewport:show()
end

hook.set( "client", showViewport, "onMainMenuClose", "showViewport" )
