#include "assimp.h"
#include <assimp/Importer.hpp>
#include <assimp/postprocess.h>
#include <assimp/scene.h>
#include <iostream>

inline void PrintVertex(const aiVector3D & vertex, const float w) { std::cout << "{" << vertex.x << ", " << vertex.y << ", " << vertex.z << ", " << w << "},"; }
inline void PrintUv(const aiVector3D & vertex) { std::cout << "{" << vertex.x << ", " << vertex.y << "},"; }

int AssimpTest::DoImport(const char * filename)
{
    auto importer = Assimp::Importer();

    const int pFlags = aiProcessPreset_TargetRealtime_Fast;
    const aiScene * scene = importer.ReadFile(filename, pFlags);
    if (!scene) throw std::runtime_error(std::string("Error while parsing data ") + std::string(importer.GetErrorString()));

    if (scene->HasMeshes()) {
        for (size_t i = 0; i < scene->mNumMeshes; i++) {
            const auto & mesh = scene->mMeshes[i];

            std::cout << "const char name[] = \"" << mesh->mName.C_Str() << "\";" << std::endl;

            std::cout << "const uint32_t vertexCount = " << mesh->mNumVertices << ";" << std::endl;

            std::cout << "const float4 vertices[] = {";
            for (size_t j = 0; j < mesh->mNumVertices; j++) { PrintVertex(mesh->mVertices[j], 1.); }
            std::cout << "};" << std::endl;

            std::cout << "const float4 normals[] = {";
            for (size_t j = 0; j < mesh->mNumVertices; j++) { PrintVertex(mesh->mNormals[j], 0.); }
            std::cout << "};" << std::endl;

            std::cout << "const float2 uvs[] = {";
            for (size_t j = 0; j < mesh->mNumVertices; j++) { PrintUv(mesh->mTextureCoords[0][j]); }
            std::cout << "};" << std::endl;

            uint32_t indexCount = 0;
            std::cout << "const uint32_t indices[] = {";
            for (size_t j = 0; j < mesh->mNumFaces; j++) {
                const auto & face = mesh->mFaces[j];
                for (size_t k = 0; k < face.mNumIndices; k++) {
                    std::cout << face.mIndices[k] << ", ";
                    ++indexCount;
                }
            }
            std::cout << "};" << std::endl;
            std::cout << "const uint32_t indexCount = " << indexCount << ";" << std::endl;
        }
    }

    return 0;
}
