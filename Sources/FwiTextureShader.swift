//  Project name: Texture
//  File name   : FwiTextureShader.swift
//
//  Author      : Phuc, Tran Huu
//  Created date: 7/14/17
//  Version     : 1.00
//  --------------------------------------------------------------
//  Copyright © 2017 BurtK. All rights reserved.
//  --------------------------------------------------------------

import GLKit


public protocol FwiTextureShader {

    /// Texture's ID.
    var texture: GLuint { get set }
    var textureUniform: Int32 { get }
}

// MARK: FwiTextureShader's default implementation
public extension FwiShader where Self: FwiTextureShader {

    public var textureUniform: Int32 {
        return glGetUniformLocation(program, "u_texture")
    }

    public func prepareShader() {
        glUseProgram(program)

        // Inject projection matrix uniform
        glUniformMatrix4fv(projectionMatrixUniform, 1, GLboolean(GL_FALSE), projectionMatrix.array)
        // Inject model matrix uniform
        glUniformMatrix4fv(modelMatrixUniform, 1, GLboolean(GL_FALSE), modelMatrix.array)

        // Inject texture uniform
        glActiveTexture(GLenum(GL_TEXTURE0))
        glBindTexture(GLenum(GL_TEXTURE_2D), texture)
        glUniform1i(textureUniform, 0)

        // In case if texture is non power of 2
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MIN_FILTER), GL_LINEAR)
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MAG_FILTER), GL_LINEAR)
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_WRAP_S), GL_CLAMP_TO_EDGE)
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_WRAP_T), GL_CLAMP_TO_EDGE)
    }
}
