#
# Copyright (C) 2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=lutok
PKG_VERSION:=0.4

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/jmmv/lutok.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=490bbc056316e0e9307aa7da207ccd36c0d66253

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/lutok
    SUBMENU:=Lua
    SECTION:=lang
    CATEGORY:=Languages
    TITLE:=Lutok
    DEPENDS:=+lua +liblua 
endef

define Package/lutok/description
	a lightweight C++ API library for Lua
endef

define Build/Configure
	$(MAKE) -C $(PKG_BUILD_DIR) \
		configure
	(cd $(PKG_BUILD_DIR); \
		./configure \
	);
endef

#define Build/Compile
#	$(MAKE) -C $(PKG_BUILD_DIR)/ \
		LIBDIR="$(TARGET_LDFLAGS)" \
		LUA_INC="$(STAGING_DIR)/usr/include/" \
		LUA_LIBDIR="$(STAGING_DIR)/usr/lib/" \
		LIB_OPTION="-shared $(TARGET_LDFLAGS)" \
		CC="$(TARGET_CXX) $(TARGET_CFLAGS) $(FPIC) -std=gnu99" \
		LD="$(TARGET_CROSS)ld -shared"

#endef

define Package/lutok/install
	$(INSTALL_DIR) $(1)/usr/lib/lua
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/.libs/liblutok.so.3.0.0 $(1)/usr/lib/lua
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/.libs/liblutok.a $(1)/usr/lib/lua
	$(INSTALL_DIR) $(1)/usr/lib/lua/lutok
endef

$(eval $(call BuildPackage,lutok))
