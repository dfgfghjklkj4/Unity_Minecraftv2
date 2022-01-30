using System.Security.Cryptography.X509Certificates;
using System.Runtime.InteropServices.ComTypes;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO.Compression;
using System.Linq;
//using System.Linq;
//using System.Numerics;
using System.Security;
using System.Security.Permissions;
using UnityEngine;
using UnityEngine.Rendering;
using static UnityEngine.Mesh;
using Debug = UnityEngine.Debug;
using Random = UnityEngine.Random;




public enum LoadFlag
{
    defailt, waitLoad, loaded, waitUnload, unlodad,
}



public class treeDate
{
    public int treeID;
    public Dictionary<Vector3, BlockType> treeDic;
}


public class NeighborBlocks
{
    public WorldChunk chunks;
    public BlockType blocks;
    // public WorldChunk chunkUp, chunkDown, chunkRight, chunkLeft, chunkForward, chunkBack;
    //  public BlockType blockUp, blockDown, blockRight, blockLeft, blockForward, blockBack;
}

public struct PerlinNoisePreCompute
{
    public static int waterLevel = 68;

    public float[,] noiseMap;
    public int[,] hightMap;
    public BlockType[,] topBlock;

    public int maxHight, minHight;



    public void PerlinCompute(int x, int z)
    {
        //  Debug.Log(x + "  " + z);
        maxHight = 0;
        minHight = 500;
        if (noiseMap == null)
        {
            hightMap = new int[ChunkManager.Instance.chunkSize.x, ChunkManager.Instance.chunkSize.z];
            noiseMap = new float[ChunkManager.Instance.chunkSize.x, ChunkManager.Instance.chunkSize.z];
            topBlock = new BlockType[ChunkManager.Instance.chunkSize.x, ChunkManager.Instance.chunkSize.z];

        }
        // PerlinNoise.GenerateNoiseMap(noiseMap, new Vector2Int(x, z), ChunkManager.Instance.chunkSize.x, ChunkManager.Instance.chunkSize.z);
        noiseMap = MapGenerator.Instanc.GenerateMapData(noiseMap, Vector2.zero, new Vector2Int(x, z), ChunkManager.Instance.chunkSize.x);
        //    noiseMap = md.noiseMap;
        for (int x1 = 0; x1 < ChunkManager.Instance.chunkSize.x; x1++)
        {
            for (int z1 = 0; z1 < ChunkManager.Instance.chunkSize.z; z1++)
            {

                float currentHeight = 0;
                //   Debug.Log(x0+"  "+z0);
                currentHeight = noiseMap[x1, z1];

                float h = MapGenerator.Instanc.heightCurve2.Evaluate(currentHeight) * 150;

                int intH = (int)h;


                if (intH >= maxHight)
                    maxHight = intH;

                if (intH < minHight)
                    minHight = intH;

                hightMap[x1, z1] = intH;
                ///////
                BlockType type = BlockType.Air;
                if (intH <= 30)
                {
                    type = BlockType.Dirt;
                }
                else if (intH > 30 && intH <= 33)
                {

                    type = BlockType.Sand;
                }

                else if (intH > 33 && intH <= 38)
                {

                    type = BlockType.GrassEdge;
                }

                else if (intH > 38 && intH <= 67)
                {
                    type = BlockType.Grass;
                }
                else if (intH > 67 && intH <= 82)
                {

                    type = BlockType.GrassHill;



                }
                else if (intH > 82 && intH <= 125)
                {
                    type = BlockType.GrassHill;

                }
                else if (intH > 125 && intH <= 142)
                {
                    type = BlockType.GrassHill;
                    // type = BlockType.HillStone;
                }
                else if (intH > 142)
                {
                    type = BlockType.HillStone;
                }
                topBlock[x1, z1] = type;
            }

        }

        return;

        //   */

    }



}



public class WorldChunk : MonoBehaviour
{

    //上下 右左 前后顺序六个块
    public static NeighborBlocks[] NeiBlocks;
    public LoadFlag flag;
    public Vector3Int ID;
    public List<int> treeslistINDEX = new List<int>();
    public bool isAir;
    public bool isBedrockC;

    public WorldChunk NeighborUp, NeighborDown, NeighborLeft, NeighborRight, NeighborForward, NeighborBack;


    public bool Initialized;


    public bool computedTerrainDate;

    public bool isEmperty = false;
    public bool isModify = false;

    public bool active;

    public bool buildMesh;
    public bool IsLoaded;


    public MeshFilter OpaqueMeshFilter, WaterMeshFilter, FoliageMeshFilter, TreeMeshFilter;
    public MeshRenderer OpaqueMeshRenderer, WaterMeshRenderer, FoliageMeshRenderer, TreeMeshRenderer;
    public MeshCollider OpaqueMeshCol, WaterMeshCol, FoliageMeshCol, TreeMeshCol;
    public BlockType[,,] Blocks;


    public int[,] hightmap;

    public int indexOfExternalBlockArray;

    public int meshesIndex;

    public MeshData_ coubinMD;
    public static bool[] visibility = new bool[6];
    public static Vector3Int[] neighborsArray = new Vector3Int[6];
    public static bool[] neighborsBlock = new bool[6];

    public static Bounds bound;

    public static Vector3 boundCenter;
    public static Vector3Int _size;
    public static Vector3Int _sizeSmallOne;

    public HashSet<Vector3Int> AddBlocks;
    public List<Vector3Int> DestroyBlocks;


    public static Queue<PerlinNoisePreCompute> PerlinDatePool = new Queue<PerlinNoisePreCompute>(1024);

    public static Dictionary<Vector2Int, PerlinNoisePreCompute> hightMapDic = new Dictionary<Vector2Int, PerlinNoisePreCompute>(1024);


    // static Vector3Int[] tempmd = new Vector3Int[256];


    public void UnUseSet()
    {
        flag = LoadFlag.defailt;
        this.blockCount = 0;


        if (!isAir && !isBedrockC)
        {
            LOD = 10000;
            haveTree = false;
            for (int i = 0; i < treeslistINDEX.Count; i++)
            {
                ObjPool.ReturnGO<Transform>(treeslist2[i], ChunkManager.Instance.trees[treeslistINDEX[i]]);

            }
            treeslist2.Clear();
            treeslistINDEX.Clear();
            if (OpaqueMeshFilter.sharedMesh.vertexCount > 0)
            {
                OpaqueMeshCol.enabled = false;
                OpaqueMeshRenderer.renderingLayerMask = 0;
                OpaqueMeshFilter.sharedMesh.Clear();
            }
            if (WaterMeshFilter.sharedMesh.vertexCount > 0)
            {
                WaterMeshCol.enabled = false;
                WaterMeshRenderer.renderingLayerMask = 0;
                WaterMeshFilter.sharedMesh.Clear();
            }
            if (FoliageMeshFilter.sharedMesh.vertexCount > 0)
            {
                FoliageMeshCol.enabled = false;
                FoliageMeshRenderer.renderingLayerMask = 0;
                FoliageMeshFilter.sharedMesh.Clear();
            }

            Initialized = false;


            computedTerrainDate = false;


            isEmperty = true;

            if (Blocks != null)
            {
                if (!shareBlocks)
                {

                    BlocksPool.Push(Blocks);



                }
                else
                {
                    shareBlocks = false;
                }
                Blocks = null;
            }

            buildMesh = false;
            IsLoaded = false;
            RemoveNeighbors();
            pool.Push(this);
            ChunkManager._chunks.Remove(ID);
        }


    }

    void RemoveNeighbors()
    {
        if (NeighborUp)
        {
            NeighborUp.NeighborDown = null;
            NeighborUp = null;
        }
        if (NeighborDown)
        {
            NeighborDown.NeighborUp = null;
            NeighborDown = null;
        }
        if (NeighborLeft)
        {
            NeighborLeft.NeighborRight = null;
            NeighborLeft = null;
        }
        if (NeighborRight)
        {
            NeighborRight.NeighborLeft = null;
            NeighborRight = null;
        }
        if (NeighborForward)
        {
            NeighborForward.NeighborBack = null;
            NeighborForward = null;
        }
        if (NeighborBack)
        {
            NeighborBack.NeighborForward = null;
            NeighborBack = null;
        }
    }
    public void StartBuildMesh()
    {
        // if (ID.y < -15)
        //   return;
        if (isEmperty)
            return;
        if (shareBlocks)
        {
            return;
        }
        //六面邻居的地形数据加载
        loadNeighborsBlocks();

        BuildOpaqueMesh();
        BuildWaterMesh();
        BuildFoliageMesh();

        if (IsLoaded)
        {
            if (!this.gameObject.activeSelf)
            {
                gameObject.SetActive(true);
            }
        }

        buildMesh = true;


    }
    public bool IsRebuildOpaqueMesh, IsRebuildWaterMesh, IsRebuildFoliageMesh;
    public bool haveTree;
    public void ReBuildMesh()
    {




        if (isEmperty)
            return;
        if (shareBlocks)
        {
            return;
        }
        //六面邻居的地形数据加载
        loadNeighborsBlocks();

        //  if(IsRebuildOpaqueMesh)
        BuildOpaqueMesh();
        //   IsRebuildOpaqueMesh = false;
        //    if (IsRebuildWaterMesh)
        BuildWaterMesh();
        //   IsRebuildWaterMesh = false;
        //  if (IsRebuildFoliageMesh)
        BuildFoliageMesh();

        buildMesh = true;


    }

    public void Initialize(Vector3Int minCorner)
    {

        if (Initialized)

            return;


        ID = minCorner;

        GetLOD();

        this.transform.position = minCorner;

        isEmperty = false;

        if (!active)
        {
            Active();
        }


        if (Blocks == null)
        {

            //  Blocks = new BlockType[ChunkManager.Instance.chunkSize.x, ChunkManager.Instance.chunkSize.y, ChunkManager.Instance.chunkSize.z];

        }
        if (hightmap == null)
        {

            hightmap = new int[ChunkManager.Instance.chunkSize.x, ChunkManager.Instance.chunkSize.z];

        }

        Initialized = true;

        Vector3Int wp = new Vector3Int(minCorner.x, minCorner.y + ChunkManager.Instance.chunkSize.y, minCorner.z);

        if (NeighborUp == null)
        {
            NeighborUp = ChunkManager.GetChunk(wp);
        }

        NeighborUp.NeighborDown = this;
        ChunkManager._chunks.Add(minCorner, this);

        return;
    }


    public void GetLOD()
    {

        // Vector2 v2 = new Vector2(ID.x, ID.z);
        Vector2 playerChunk = new Vector2(ChunkManager.Instance.currentChunkPos.x, ChunkManager.Instance.currentChunkPos.z);
        float xdis = Mathf.Abs(ID.x - ChunkManager.Instance.currentChunkPos.x) / ChunkManager.Instance.chunkSize.x;
        float zdis = Mathf.Abs(ID.z - ChunkManager.Instance.currentChunkPos.z) / ChunkManager.Instance.chunkSize.z;
        if (xdis <= 0.001f && zdis <= 0.001f)
        {
            LOD = 0;
        }
        else if (xdis <= 1.001f && zdis <= 1.001f || zdis <= 1.001f && xdis <= 1.001f)
        {
            LOD = 1;
        }
        else if (xdis <= 2.001f && zdis <= 2.001f || zdis <= 2.001f && xdis <= 2.001f)
        {
            LOD = 2;
        }
        else if (xdis <= 3.001f && zdis <= 3.001f || zdis <= 3.001f && xdis <= 3.001f)
        {
            LOD = 3;
        }
        else if (xdis <= 4.001f && zdis <= 4.001f || zdis <= 4.001f && xdis <= 4.001f)
        {
            LOD = 4;
        }
        else
        {
            LOD = 10000;
        }
    }

    public void InitializeNeighbors()
    {
        //不能放在初始化方法里 会造成死循环
        Vector3Int wp;




        wp = new Vector3Int(ID.x, ID.y + ChunkManager.Instance.chunkSize.y, ID.z);

        if (NeighborUp == null)
        {
            NeighborUp = ChunkManager.GetChunk(wp);
        }


        NeighborUp.NeighborDown = this;



        if (!NeighborDown)
        {
            wp = new Vector3Int(ID.x, ID.y - ChunkManager.Instance.chunkSize.y, ID.z);
            if (!ChunkManager._chunks.TryGetValue(wp, out NeighborDown))
            {
                NeighborDown = WorldChunk.GetChunk();
                NeighborDown.Initialize(wp);
            }

        }
        NeighborDown.NeighborUp = this;
        //    */


        if (!NeighborForward)
        {
            wp = new Vector3Int(ID.x, ID.y, ID.z + ChunkManager.Instance.chunkSize.z);
            if (!ChunkManager._chunks.TryGetValue(wp, out NeighborForward))
            {
                NeighborForward = WorldChunk.GetChunk();
                NeighborForward.Initialize(wp);
            }

        }
        NeighborForward.NeighborBack = this;
        if (!NeighborBack)
        {
            wp = new Vector3Int(ID.x, ID.y, ID.z - ChunkManager.Instance.chunkSize.z);
            if (!ChunkManager._chunks.TryGetValue(wp, out NeighborBack))
            {

                NeighborBack = WorldChunk.GetChunk();
                NeighborBack.Initialize(wp);
            }

        }
        NeighborBack.NeighborForward = this;
        if (!NeighborLeft)
        {
            wp = new Vector3Int(ID.x - ChunkManager.Instance.chunkSize.x, ID.y, ID.z);
            if (!ChunkManager._chunks.TryGetValue(wp, out NeighborLeft))
            {
                NeighborLeft = WorldChunk.GetChunk();
                NeighborLeft.Initialize(wp);
            }

        }
        NeighborLeft.NeighborRight = this;

        if (!NeighborRight)
        {
            wp = new Vector3Int(ID.x + ChunkManager.Instance.chunkSize.x, ID.y, ID.z);
            if (!ChunkManager._chunks.TryGetValue(wp, out NeighborRight))
            {
                NeighborRight = WorldChunk.GetChunk();
                NeighborRight.Initialize(wp);
            }

        }
        NeighborRight.NeighborLeft = this;

        return;
    }


    public int blockCount;

    public void CreateTerrainDate()
    {

        if (computedTerrainDate)

            return;


        if (NeighborUp == null)
        {
            Vector3Int wp = new Vector3Int(ID.x, ID.y + ChunkManager.Instance.chunkSize.y, ID.z);
            NeighborUp = ChunkManager.GetChunk(wp);
        }
        NeighborUp.NeighborDown = this;

        Vector2Int mapid = new Vector2Int(ID.x, ID.z);
        PerlinNoisePreCompute pnpc;
        if (!hightMapDic.TryGetValue(mapid, out pnpc))
        {
            if (PerlinDatePool.Count > 0)
            {
                pnpc = PerlinDatePool.Dequeue();
            }
            else
            {
                pnpc = new PerlinNoisePreCompute();

            }

            pnpc.PerlinCompute(ID.x, ID.z);

            hightMapDic.Add(mapid, pnpc);
        }
        else
        {

        }
        // /*
        if (ID.y < pnpc.minHight - _size.y)
        //  if (!NeighborUp.isAir&& NeighborUp.isEmperty)
        //  if (false)
        {
            //  Debug.Log(2);
            //   fullShutoutDown = false;
            isEmperty = false;
            computedTerrainDate = true;
            Blocks = StoneBlocks;
            shareBlocks = true;
            return;
        }


        if (ID.y > pnpc.maxHight && ID.y > 30)
        {
            //    Debug.Log(2);
            //   fullShutoutDown = false;
            isEmperty = true;
            computedTerrainDate = true;

            Blocks = AirBlocks;
            shareBlocks = true;
            // Debug.Log(666);
            return;
        }
        //   */

        bool eee = false;
        isEmperty = true;




        Blocks = GetBlocks();



        blockCount = 0;
        for (int x = 0; x < _size.x; x++)
        {
            int wpx = x + ID.x;
            for (int z = 0; z < _size.z; z++)
            {
                int wpz = z + ID.z;
                int h = 0;

                dirtThickness = NeighborUp.dirtThickness;
                for (int y = _sizeSmallOne.y; y > -1; y--)
                //for (int y = 0; y < _size.y; y++)
                {
                    // float t = Time.realtimeSinceStartup; 
                    BlockType type = GetBlockType(x, y, z, pnpc);
                    //  BlockType type = GetBlockType(wpx, y + ID.y, wpz, _seed);
                    //   t = Time.realtimeSinceStartup - t;
                    if (!type.isTransparent)

                    {

                        blockCount++;
                        if (!eee)
                        {
                            h = y;
                            eee = true;
                        }


                    }
                    if (!type.isAir)
                    {

                        if (isEmperty)
                            isEmperty = false;
                    }

                    // if (type.blockName!=BlockNameEnum.Air)
                    // var t = Blocks[x, y, z];
                    //   if (t==null||!t.isTree)
                    // {
                    Blocks[x, y, z] = type;
                    //  }


                }
                if (eee)
                {
                    //发现了不透明的方块 
                    eee = false;
                    hightmap[x, z] = h;
                    // if (isEmperty)
                    //     isEmperty = false;
                    // h = 0;

                }
                else
                {
                    hightmap[x, z] = 0;
                    //如果整个竖排从下到上都没有不透明的方块 就不能完全遮住下面的chunk


                }


            }
        }

        computedTerrainDate = true;


    }

    public void CreateTerrainDate0()
    {

        if (computedTerrainDate)

            return;


        if (NeighborUp == null)
        {
            Vector3Int wp = new Vector3Int(ID.x, ID.y + ChunkManager.Instance.chunkSize.y, ID.z);
            NeighborUp = ChunkManager.GetChunk(wp);
        }
        NeighborUp.NeighborDown = this;

        Vector2Int mapid = new Vector2Int(ID.x, ID.z);
        PerlinNoisePreCompute pnpc;
        if (!hightMapDic.TryGetValue(mapid, out pnpc))
        {
            if (PerlinDatePool.Count > 0)
            {
                pnpc = PerlinDatePool.Dequeue();
            }
            else
            {
                pnpc = new PerlinNoisePreCompute();

            }

            pnpc.PerlinCompute(ID.x, ID.z);

            hightMapDic.Add(mapid, pnpc);
        }
        else
        {

        }
        // /*
        if (ID.y < pnpc.minHight - _size.y)
        //  if (!NeighborUp.isAir&& NeighborUp.isEmperty)
        //  if (false)
        {
            //   Debug.Log(2);
            //   fullShutoutDown = false;
            isEmperty = true;
            computedTerrainDate = true;
            for (int x = 0; x < ChunkManager.Instance.chunkSize.x; x++)
            {
                for (int y = 0; y < ChunkManager.Instance.chunkSize.y; y++)
                {
                    for (int z = 0; z < ChunkManager.Instance.chunkSize.z; z++)
                    {
                        //   Blocks[x, y, z] = BlockType.Stone;
                    }
                }
            }

        }


        if (ID.y > pnpc.maxHight)
        {
            //    Debug.Log(2);
            //   fullShutoutDown = false;
            isEmperty = true;
            computedTerrainDate = true;
            for (int x = 0; x < ChunkManager.Instance.chunkSize.x; x++)
            {
                for (int y = 0; y < ChunkManager.Instance.chunkSize.y; y++)
                {
                    for (int z = 0; z < ChunkManager.Instance.chunkSize.z; z++)
                    {
                        //  Blocks[x, y, z] = BlockType.Air;
                    }
                }
            }


            //    Debug.Log(pnpc.maxHight+"  "+ID);
            //   return;
        }
        //   */

        bool eee = false;
        isEmperty = true;
        blockCount = 0;
        for (int x = 0; x < _size.x; x++)
        {
            int wpx = x + ID.x;
            for (int z = 0; z < _size.z; z++)
            {
                int wpz = z + ID.z;
                int h = 0;

                dirtThickness = NeighborUp.dirtThickness;
                for (int y = _sizeSmallOne.y; y > -1; y--)
                //for (int y = 0; y < _size.y; y++)
                {
                    // float t = Time.realtimeSinceStartup; 
                    BlockType type = GetBlockType(x, y, z, pnpc);
                    //  BlockType type = GetBlockType(wpx, y + ID.y, wpz, _seed);
                    //   t = Time.realtimeSinceStartup - t;
                    if (!type.isTransparent)

                    {

                        blockCount++;
                        if (!eee)
                        {
                            h = y;
                            eee = true;
                        }


                    }
                    if (!type.isAir)
                    {

                        if (isEmperty)
                            isEmperty = false;
                    }

                    // if (type.blockName!=BlockNameEnum.Air)
                    // var t = Blocks[x, y, z];
                    //   if (t==null||!t.isTree)
                    // {
                    Blocks[x, y, z] = type;
                    //  }


                }
                if (eee)
                {
                    //发现了不透明的方块 
                    eee = false;
                    hightmap[x, z] = h;
                    // if (isEmperty)
                    //     isEmperty = false;
                    // h = 0;

                }
                else
                {
                    hightmap[x, z] = 0;
                    //如果整个竖排从下到上都没有不透明的方块 就不能完全遮住下面的chunk


                }


            }
        }

        computedTerrainDate = true;


    }




    public void Active()
    {
        if (!active)
        {
            AddBlocks = new HashSet<Vector3Int>();
            DestroyBlocks = new List<Vector3Int>();



            // gameObject.name = ID.ToString();
            Mesh m1 = new Mesh();
            OpaqueMeshFilter.sharedMesh = m1;
            //    dataArray = Mesh.AllocateWritableMeshData(1);
            // data = dataArray[0];
            OpaqueMeshCol.sharedMesh = OpaqueMeshFilter.sharedMesh;

            Mesh m2 = new Mesh();
            WaterMeshFilter.sharedMesh = m2;
            // WaterMeshCol = WaterMeshFilter.GetComponent<MeshCollider>();
            WaterMeshCol.sharedMesh = WaterMeshFilter.sharedMesh;

            Mesh m3 = new Mesh();
            FoliageMeshFilter.sharedMesh = m3;
            //  FoliageMeshCol = FoliageMeshFilter.GetComponent<MeshCollider>();
            FoliageMeshCol.sharedMesh = FoliageMeshFilter.sharedMesh;



            active = true;
        }

    }








    int dirtThickness;
    BlockType GetBlockType(int x, int y, int z, PerlinNoisePreCompute pnpc)
    {

        int worldY = ID.y + y;
        BlockType type = BlockType.Air;
        // MapData md = pnpc.md;
        int mapHeight = pnpc.hightMap[x, z];
        if (worldY > mapHeight)
        {
            if (worldY <= 30)
            {
                type = BlockType.Water;
                return type;
            }
            else
            {
                return type;
            }
        }
        else if (worldY == mapHeight)
        {
            type = pnpc.topBlock[x, z];
            //最上面一层不做判断 麻烦
            if (y < _sizeSmallOne.y)
            {
                BlockType topBlock = null;
                float plantProbability = Random.value;
                float p = Random.value;

                if (type.flag == BlockFlag.grassTop)
                {



                    if (plantProbability < 0.2f)
                    {



                        topBlock = BlockType.GetTallGrassBlock();
                        if (p < 0.2f)
                        {
                            topBlock = BlockType.GetPlantBlockTypes();

                        }
                        else if (p >= 0.45f && p < 0.452f || p >= 0.5 && p < 0.501f)
                        {

                            topBlock = BlockType.Tree1;
                        }

                    }
                }

                else if (type.flag == BlockFlag.grass2water)
                {



                    if (plantProbability < 0.2f)
                    {


                        topBlock = BlockType.GetTallGrassBlock();
                        //  treePosDic2.Add(new Vector3Int(x, y - ID.y, z), tree02);
                        if (p < 0.2f)
                        {
                            topBlock = BlockType.GetPlantBlockTypes();

                        }
                        else if (p >= 0.45f && p < 0.49f || p >= 0.5 && p < 0.51f)
                        // else if (p >= 0.25f && p < 0.255f )
                        {

                            topBlock = BlockType.Tree1;
                        }
                        //水周边有更多的植被





                    }
                }
                if (topBlock != null)
                {
                    Blocks[x, y + 1, z] = topBlock;
                }
            }


        }
        else
        {
            if (worldY <= -10)
            {
                type = BlockType.Bedrock;
            }
            else if (worldY > -10 && worldY <= 0)
            {
                type = BlockType.Stone;
            }
            else if (worldY > 0)
            {
                var topType = pnpc.topBlock[x, z];
                if (mapHeight <= 30)
                {
                    if (dirtThickness < 5)
                    {
                        type = BlockType.Dirt;
                        dirtThickness++;
                    }
                    else
                    {
                        type = BlockType.Stone;
                    }

                }
                else if (mapHeight > 30 && mapHeight <= 33)
                {
                    if (topType == BlockType.Sand)
                    {
                        type = BlockType.Sand;
                    }
                    else
                    {
                        if (dirtThickness < 5)
                        {
                            type = BlockType.Dirt;
                            dirtThickness++;
                        }
                        else
                        {
                            type = BlockType.Stone;
                        }
                    }

                }

                else if (mapHeight > 33 && mapHeight <= 40)
                {

                    if (dirtThickness < 5)
                    {
                        type = BlockType.Dirt;
                        dirtThickness++;
                    }
                    else
                    {
                        type = BlockType.Stone;
                    }
                }

                else if (mapHeight > 40 && mapHeight <= 67)
                {
                    if (dirtThickness < 5)
                    {
                        type = BlockType.Dirt;
                        dirtThickness++;
                    }
                    else
                    {
                        type = BlockType.Stone;
                    }
                }
                else if (mapHeight > 67 && mapHeight <= 82)
                {

                    type = BlockType.Dirt;
                    //   type = BlockType.Grass;


                }
                else if (mapHeight > 82 && mapHeight <= 125)
                {
                    type = BlockType.Dirt;
                    //  type = BlockType.Grass;
                }
                else if (mapHeight > 125 && mapHeight <= 142)
                {
                    //  type = BlockType.Grass;
                    type = BlockType.Dirt;
                }
                else if (mapHeight > 142)
                {
                    type = BlockType.Dirt;
                }
            }

        }


        ///*

        return type;

    }

    //public static Dictionary<Vector3Int, BlockType> treePosDic = new Dictionary<Vector3Int, BlockType>();

    public void BuildOpaqueMesh()
    {
        meshesIndex = 0;
        coubinMD = MeshData_.GetMax();

        int ccc = 0;
        //  /*
        for (int x = 0; x < _size.x; x++)
        {
            for (int z = 0; z < _size.z; z++)
            {
                int maxy = hightmap[x, z];
                int miniy = GetMiny(x, z, maxy);

                for (int y = miniy; y < _size.y; y++)
                //  for (int y = 0; y < _size.y; y++)
              //  for (int y = _sizeSmallOne.y; y > -1; y--)
                {

                    BlockType block = Blocks[x, y, z];

                    if (block.isTransparent)

                        continue;
                    indexOfExternalBlockArray++;
                    bool quauCount = GetVisibility002(x, y, z, visibility);

                    if (quauCount)
                    {
                        ccc++;
                        int index = meshesIndex;

                        int vc = block.GenerateMesh(visibility, coubinMD, ref meshesIndex);
                        for (int ii = 0; ii < vc; ii++)
                        {
                            int newIndex = index + ii;
                            Vector3 vp = coubinMD.vertexDate[newIndex].vertice;
                            vp.Set(vp.x + x, vp.y + y, vp.z + z);
                            coubinMD.vertexDate[newIndex].vertice = vp;

                        }

                    }
                    //  }



                }
            }
        }

        if (meshesIndex == 0)
        {


            OpaqueMeshRenderer.renderingLayerMask = 0;
            MeshData_.ReturnMax(coubinMD);
            indexOfExternalBlockArray = 0;
            return;
        }
        if (!IsLoaded)
            IsLoaded = true;



        Mesh mesh = OpaqueMeshFilter.sharedMesh;
        coubinMD.vertexCount = meshesIndex;
        //   MeshData_.Combine(coubinMD,  mesh);
        MeshData_.Combine(this, ref mesh);
        OpaqueMeshCol.sharedMesh = OpaqueMeshFilter.sharedMesh;

        ChunkManager.Instance.totolVc += OpaqueMeshFilter.sharedMesh.vertexCount;
        MeshData_.ReturnMax(coubinMD);

        if (LOD <= 3)
        {
            OpaqueMeshRenderer.shadowCastingMode = ShadowCastingMode.On;

            OpaqueMeshRenderer.receiveShadows = true;

            OpaqueMeshCol.enabled = true;
            OpaqueMeshRenderer.sharedMaterial = ChunkManager.Instance.Opaque;
        }
        else
        {
            OpaqueMeshRenderer.sharedMaterial = ChunkManager.Instance.Opaque;
            OpaqueMeshCol.enabled = false;
        }


        if (OpaqueMeshRenderer.renderingLayerMask == 0)
            OpaqueMeshRenderer.renderingLayerMask = 1;
        return;
    }



    public void BuildWaterMesh()
    {
        meshesIndex = 0;
        coubinMD = MeshData_.GetMax();


        int ccc = 0;
        //  /*
        for (int x = 0; x < _size.x; x++)
        {

            for (int z = 0; z < _size.z; z++)
            {

                for (int y = _sizeSmallOne.y; y > -1; y--)

                {

                    BlockType block = Blocks[x, y, z];
                    if (!block.isWater)
                        continue;


                    indexOfExternalBlockArray++;
                    bool quauCount = GetVisibilityWater(x, y, z, visibility, block);
                    if (quauCount)
                    {

                        ccc++;
                        int index = meshesIndex;
                        int vc = block.GenerateWaterFaces(visibility, coubinMD, ref meshesIndex);
                        for (int ii = 0; ii < vc; ii++)
                        {
                            int newIndex = index + ii;
                            Vector3 vp = coubinMD.vertexDate[newIndex].vertice;
                            vp.Set(vp.x + x, vp.y + y, vp.z + z);
                            coubinMD.vertexDate[newIndex].vertice = vp;

                        }

                    }
                    break;
                    //  }



                }
            }
        }


        if (meshesIndex == 0)
        {
            //  if (WaterMeshRenderer.renderingLayerMask == 1)
            WaterMeshRenderer.renderingLayerMask = 0;
            MeshData_.ReturnMax(coubinMD);
            indexOfExternalBlockArray = 0;
            return;
        }
        if (!IsLoaded)
            IsLoaded = true;


        Mesh mesh = WaterMeshFilter.sharedMesh;
        coubinMD.vertexCount = meshesIndex;
        //  MeshData_.Combine(coubinMD, mesh);
        MeshData_.Combine(this, ref mesh);
        WaterMeshCol.sharedMesh = mesh;

        ChunkManager.Instance.totolVc += WaterMeshFilter.sharedMesh.vertexCount;
        MeshData_.ReturnMax(coubinMD);

        if (LOD <= 3)
        {
            WaterMeshRenderer.shadowCastingMode = ShadowCastingMode.On;
            WaterMeshRenderer.receiveShadows = true;
            WaterMeshRenderer.sharedMaterial = ChunkManager.Instance.Water;
            WaterMeshCol.enabled = true;
        }
        else
        {
            WaterMeshRenderer.sharedMaterial = ChunkManager.Instance.Water;
            WaterMeshCol.enabled = false;
        }
        if (WaterMeshRenderer.renderingLayerMask == 0)
            WaterMeshRenderer.renderingLayerMask = 1;
        return;
    }

    public int LOD = -1;
    public List<Transform> treeslist2 = new List<Transform>();
    public void BuildFoliageMesh()
    {
        meshesIndex = 0;
        coubinMD = MeshData_.GetMax();

        float f = Time.realtimeSinceStartup;

        int ccc = 0;
        int treeCount = 0;
        //  /*
        for (int x = 0; x < _size.x; x++)
        {
            for (int z = 0; z < _size.z; z++)
            {
                for (int y = _sizeSmallOne.y; y > -1; y--)
                //  for (int y = 0; y < _size.y; y++)

                {

                    BlockType block = Blocks[x, y, z];
                    if (block == BlockType.Tree1 && !haveTree)
                    {
                         int treeindex0 = Random.Range(0, ChunkManager.Instance.trees.Count);
                         treeslistINDEX.Add(treeindex0);
                         treeslist2.Add(ObjPool.GetComponent<Transform>(ChunkManager.Instance.trees[treeindex0], new Vector3(ID.x + x, ID.y + y - 0.7f, ID.z + z), Quaternion.identity));
                        break;

                    }

                    if (!block.isBillboard)
                        continue;

                    indexOfExternalBlockArray++;

                    ccc++;
                    int index = meshesIndex;
                    int vc = block.GenerateBillboardFaces(coubinMD, ref meshesIndex);
                    for (int ii = 0; ii < vc; ii++)
                    {
                        int newIndex = index + ii;
                        Vector3 vp = coubinMD.vertexDate[newIndex].vertice;
                        vp.Set(vp.x + x, vp.y + y, vp.z + z);
                        coubinMD.vertexDate[newIndex].vertice = vp;
                    }


                }
            }
        }

        haveTree = true;

        if (meshesIndex == 0)
        {
            //  if (FoliageRenderer.renderingLayerMask == 1)
            FoliageMeshRenderer.renderingLayerMask = 0;
            MeshData_.ReturnMax(coubinMD);
            indexOfExternalBlockArray = 0;
            return;
        }
        if (!IsLoaded)
            IsLoaded = true;


        Mesh mesh = FoliageMeshFilter.sharedMesh;
        coubinMD.vertexCount = meshesIndex;
        // MeshData_.Combine(coubinMD, mesh);
        MeshData_.Combine(this, ref mesh);
        FoliageMeshCol.sharedMesh = mesh;

        ChunkManager.Instance.totolVc += FoliageMeshFilter.sharedMesh.vertexCount;
        MeshData_.ReturnMax(coubinMD);

        if (LOD <= 3)
        {
            FoliageMeshRenderer.shadowCastingMode = ShadowCastingMode.On;
            FoliageMeshRenderer.receiveShadows = true;

            FoliageMeshCol.enabled = true;
            FoliageMeshRenderer.sharedMaterial = ChunkManager.Instance.Foliage;
        }
        else
        {
            FoliageMeshRenderer.sharedMaterial = ChunkManager.Instance.Foliage;
            //   FoliageMeshRenderer.gameObject.SetActive(false);
        }


        if (FoliageMeshRenderer.renderingLayerMask == 0)
            FoliageMeshRenderer.renderingLayerMask = 1;
        return;
    }
    /*
     
         */

    //判断一个方块四面的高度进行对比 可以减少一部分判断计算 如果中间的方块比四周的方块高出一格 那么中间的方块就不用从上到下全部做剔除操作了 只要最上面的一个方块做测试就行了 下面的都被挡住了 是看不到的
    protected int GetMiny(int x, int z, int maxy)
    {


        int miny = maxy;
        int temp;

        if (x == 0 || z == 0 || x == _sizeSmallOne.x || z == _sizeSmallOne.z)
        {
            bool x0 = true; bool z0 = true;
            bool x1 = true; bool z1 = true;

            if (x == 0)
            {
                x1 = false;
                temp = NeighborLeft.hightmap[_sizeSmallOne.x, z];
                if (miny > temp)
                    miny = temp;

            }
            if (x == _sizeSmallOne.x)
            {
                x0 = false;
                temp = NeighborRight.hightmap[0, z];
                if (miny > temp)
                    miny = temp;
            }

            if (z == 0)
            {
                z1 = false;
                temp = NeighborBack.hightmap[x, _sizeSmallOne.z];
                if (miny > temp)
                    miny = temp;
            }
            if (z == _sizeSmallOne.z)
            {
                z0 = false;
                temp = NeighborForward.hightmap[x, 0];
                if (miny > temp)
                    miny = temp;
            }


            if (x0)
            {
                temp = hightmap[x + 1, z];
                if (miny > temp)
                    miny = temp;
            }
            if (x1)
            {
                temp = hightmap[x - 1, z];
                if (miny > temp)
                    miny = temp;
            }
            if (z0)
            {
                temp = hightmap[x, z + 1];
                if (miny > temp)
                    miny = temp;
            }
            if (z1)
            {
                temp = hightmap[x, z - 1];
                if (miny > temp)
                    miny = temp;

            }

            return miny;
        }
        else
        {
            temp = hightmap[x + 1, z];
            if (miny > temp)
                miny = temp;
            temp = hightmap[x - 1, z];
            if (miny > temp)
                miny = temp;
            temp = hightmap[x, z + 1];
            if (miny > temp)
                miny = temp;
            temp = hightmap[x, z - 1];
            if (miny > temp)
                miny = temp;
            return miny;
        }

    }









    protected bool GetVisibility002(int x, int y, int z, bool[] visibility_)
    {



        //chunk 外围的方块
        // if(block.side)



        if (y == _sizeSmallOne.y)
        {
            if (!NeighborUp.isEmperty)
            {
                visibility_[0] = NeighborUp.Blocks[x, 0, z].isTransparent;

            }
            else

                visibility_[0] = true;


            visibility_[1] = Blocks[x, y - 1, z].isTransparent;

        }
        else if (y == 0)
        {



            visibility_[0] = Blocks[x, y + 1, z].isTransparent;


            if (!NeighborDown.isEmperty)
                visibility_[1] = NeighborDown.Blocks[x, _sizeSmallOne.y, z].isTransparent;
            else
                visibility_[1] = false;




        }
        else
        {
            visibility_[0] = Blocks[x, y + 1, z].isTransparent;

            visibility_[1] = Blocks[x, y - 1, z].isTransparent;
        }

        ////////////////////
        if (x == _sizeSmallOne.x)
        {


            if (NeighborRight.computedTerrainDate)
                visibility_[2] = NeighborRight.Blocks[0, y, z].isTransparent;

            else
                visibility_[2] = true;

            visibility_[3] = Blocks[x - 1, y, z].isTransparent;


        }

        else if (x == 0)
        {


            visibility_[2] = Blocks[x + 1, y, z].isTransparent;

            if (NeighborLeft.computedTerrainDate)
                visibility_[3] = NeighborLeft.Blocks[_sizeSmallOne.x, y, z].isTransparent;

            else
                visibility_[3] = true;

        }
        else
        {
            visibility_[2] = Blocks[x + 1, y, z].isTransparent;

            visibility_[3] = Blocks[x - 1, y, z].isTransparent;
        }
        if (z == _sizeSmallOne.z)
        {



            if (NeighborForward.computedTerrainDate)
                visibility_[4] = NeighborForward.Blocks[x, y, 0].isTransparent;

            else
                visibility_[4] = true;


            visibility_[5] = Blocks[x, y, z - 1].isTransparent;

        }
        else if (z == 0)
        {

            visibility_[4] = Blocks[x, y, z + 1].isTransparent;

            if (NeighborBack.computedTerrainDate)
                visibility_[5] = NeighborBack.Blocks[x, y, _sizeSmallOne.z].isTransparent;

            else
                visibility_[5] = true;



        }
        else
        {

            visibility_[4] = Blocks[x, y, z + 1].isTransparent;

            visibility_[5] = Blocks[x, y, z - 1].isTransparent;

        }




        for (int ni = 0; ni < 6; ni++)
        {
            if (visibility_[ni])
                return true;
        }

        return false;

    }



    protected bool GetVisibilityWater(int x, int y, int z, bool[] visibility_, BlockType block)
    {

        if (y == _sizeSmallOne.y)
        {
            if (NeighborUp.computedTerrainDate)
            {
                var temp2 = NeighborUp.Blocks[x, 0, z];
                if (temp2.isWater)

                    return false;
                else
                {
                    return true;
                }



            }
            else
            {
                return true;

            }

        }


        var temp = Blocks[x, y + 1, z];
        if (temp.isWater)

            return false;
        else
        {
            return true;
        }



    }



    public void loadNeighborsBlocks()
    {


        InitializeNeighbors();

        if (!computedTerrainDate)
            CreateTerrainDate();



        if (!NeighborRight.computedTerrainDate)
            NeighborRight.CreateTerrainDate();

        if (!NeighborLeft.computedTerrainDate)
            NeighborLeft.CreateTerrainDate();

        if (!NeighborForward.computedTerrainDate)
            NeighborForward.CreateTerrainDate();

        if (!NeighborBack.computedTerrainDate)
            NeighborBack.CreateTerrainDate();

        if (!NeighborUp.computedTerrainDate)
            NeighborUp.CreateTerrainDate();


        //  if (NeighborDown)
        //   {
        if (!NeighborDown.computedTerrainDate)
            NeighborDown.CreateTerrainDate();
        //    }


        //  block.side = false;
        // BlockType ntype;





        return;

    }




    public Vector3Int WorldToLocalPosition(Vector3Int worldPos)
    {
        return worldPos - ID;
    }

    private bool LocalPositionIsInRange(Vector3Int localPos)
    {
        //  return localPos.x >= 0 && localPos.z >= 0 && localPos.x < _size.x && localPos.z < _size.z && localPos.y >= 0 && localPos.y < _size.y;
        if (localPos.x > _sizeSmallOne.x || localPos.y > _sizeSmallOne.y || localPos.z > _sizeSmallOne.z || localPos.x < 0 || localPos.y < 0 || localPos.z < 0)
        {
            return false;
        }
        else
        {
            return true;
        }
    }

    //chunk坐标
    public BlockType GetBlockAtWorldPosition(Vector3Int worldPos)
    {


        if (isAir)
        {
            return BlockType.Air;
        }

        Vector3Int localPos = WorldToLocalPosition(worldPos);
        return GetBlockAtChunkPos(localPos.x, localPos.y, localPos.z);
    }


    public BlockType GetBlockAtChunkPos(int x, int y, int z)
    {



        if (!computedTerrainDate)
        {
            CreateTerrainDate();
        }
        return Blocks[x, y, z];
    }



    public void PlaceBlock(Vector3Int loclpPos, BlockType block)
    {

        if (isEmperty)
        {
            shareBlocks = false;
            isEmperty = false;
            if (shareBlocks)
            {
                SwitchBlocks();

            }



        }
        if (!isModify)
            isModify = true;


        if (!block.isTransparent)
        {
            // if (lpos.y != 0)
            var h = hightmap[loclpPos.x, loclpPos.z];
            if (loclpPos.y > h)
            {
                hightmap[loclpPos.x, loclpPos.z] = loclpPos.y + 1;
            }

        }
        Blocks[loclpPos.x, loclpPos.y, loclpPos.z] = block;



        hightmap[loclpPos.x, loclpPos.z]++;
        ChunkManager.addChunks.Add(this);

    }




    public void GetNeighborBlocks(int x, int y, int z)
    {

        if (y == _sizeSmallOne.y)
        {
            NeiBlocks[0].chunks = NeighborUp;
            if (!NeighborUp.isEmperty)
                NeiBlocks[0].blocks = NeighborUp.Blocks[x, 0, z];
            else
                NeiBlocks[0].blocks = BlockType.Air;



            NeiBlocks[1].chunks = this;
            NeiBlocks[1].blocks = Blocks[x, y - 1, z];

        }
        ////////////////////
        else if (y == 0)
        {

            NeiBlocks[0].chunks = this;
            NeiBlocks[0].blocks = Blocks[x, y + 1, z];
            NeiBlocks[1].chunks = NeighborDown;
            if (!NeighborDown.isEmperty)
                NeiBlocks[1].blocks = NeighborDown.Blocks[x, _sizeSmallOne.y, z];
            else
                NeiBlocks[1].blocks = BlockType.Air;

        }
        else
        {
            NeiBlocks[0].chunks = this;
            NeiBlocks[0].blocks = Blocks[x, y + 1, z];

            NeiBlocks[1].chunks = this;
            NeiBlocks[1].blocks = Blocks[x, y - 1, z];
        }

        ////////////////////
        if (x == _sizeSmallOne.x)
        {
            NeiBlocks[2].chunks = NeighborRight;
            if (!NeighborRight.isEmperty)
                NeiBlocks[2].blocks = NeighborRight.Blocks[0, y, z];
            else
                NeiBlocks[2].blocks = BlockType.Air;

            NeiBlocks[3].chunks = this;
            NeiBlocks[3].blocks = Blocks[x - 1, y, z];


        }

        else if (x == 0)
        {

            NeiBlocks[2].chunks = this;
            NeiBlocks[2].blocks = Blocks[x + 1, y, z];
            NeiBlocks[3].chunks = NeighborLeft;
            if (!NeighborLeft.isEmperty)
                NeiBlocks[3].blocks = NeighborLeft.Blocks[_sizeSmallOne.x, y, z];
            else
                NeiBlocks[3].blocks = BlockType.Air;

        }
        else
        {
            NeiBlocks[2].chunks = this;
            NeiBlocks[2].blocks = Blocks[x + 1, y, z];
            NeiBlocks[3].chunks = this;
            NeiBlocks[3].blocks = Blocks[x - 1, y, z];



        }
        if (z == _sizeSmallOne.z)

        {

            NeiBlocks[4].chunks = NeighborForward;
            if (!NeighborForward.isEmperty)
                NeiBlocks[4].blocks = NeighborForward.Blocks[x, y, 0];
            else
                NeiBlocks[4].blocks = BlockType.Air;
            NeiBlocks[5].chunks = this;
            NeiBlocks[5].blocks = Blocks[x, y, z - 1];



        }
        else if (z == 0)
        {

            NeiBlocks[4].chunks = this;
            NeiBlocks[4].blocks = Blocks[x, y, z + 1];
            NeiBlocks[5].chunks = NeighborBack;
            if (!NeighborBack.isEmperty)
                NeiBlocks[5].blocks = NeighborBack.Blocks[x, y, _sizeSmallOne.z];
            else
                NeiBlocks[5].blocks = BlockType.Air;


        }
        else
        {
            NeiBlocks[4].chunks = this;
            NeiBlocks[4].blocks = Blocks[x, y, z + 1];

            NeiBlocks[5].chunks = this;
            NeiBlocks[5].blocks = Blocks[x, y, z - 1];
        }

        return;
    }



    public void DesttroyBlocksFun()
    {

        // public static BlockType[,,] bedrockBlocks;
        if (!isModify)
            isModify = true;
        if (shareBlocks)
        {
            SwitchBlocks();

        }

        foreach (var lpos in DestroyBlocks)
        {
            BlockType block = Blocks[lpos.x, lpos.y, lpos.z];
            if (block.isTree)
            {
                //  Blocks[lpos.x, lpos.y, lpos.z] = BlockType.Air;
                continue;
            }
            if (block.isPlant)
            {

            }
            bool haveWaterAround = false;//周围有没有水

            int x = lpos.x; int y = lpos.y; int z = lpos.z;

            GetNeighborBlocks(x, y, z);
            for (int i = 0; i < NeiBlocks.Length; i++)
            {
                var n = NeiBlocks[i];
                if (n.chunks.shareBlocks)
                    n.chunks.SwitchBlocks();

                if (!haveWaterAround)
                {
                    if (i!=1)//下面的水不会跑到上面来 
                    {
                         if (n.blocks.isWater)
                        haveWaterAround = true;
                    }
                   
                }
                ChunkManager.TouchedChunks.Add(n.chunks);
               

            }

         


            if (block.isBillboard)
            {
                IsRebuildFoliageMesh = true;
            }
            if (block.isWater)
            {
                IsRebuildWaterMesh = true;
            }
            if (!block.isTransparent)
            {
                IsRebuildOpaqueMesh = true;
                // if (lpos.y != 0)
                int h = hightmap[lpos.x, lpos.z];
                //   Debug.Log(lpos+" zzzzzz "+h );
                if (h >= lpos.y)
                {

                    h = lpos.y - 1;
                    if (h == -1)
                        h = 0;
                    hightmap[lpos.x, lpos.z] = h;

                }


            }


            if (haveWaterAround)
            {
                Blocks[lpos.x, lpos.y, lpos.z] = BlockType.Water;
                IsRebuildWaterMesh = true;
                //还要考虑四周是不是有空方块
                WaterFlowCheck(lpos.x, lpos.y, lpos.z);
            }
            else
            {
                Blocks[lpos.x, lpos.y, lpos.z] = BlockType.Air;
                if (block.blockName == BlockNameEnum.Grass)
                {
                    if (lpos.y < _sizeSmallOne.y)
                    {
                        if (Blocks[lpos.x, lpos.y + 1, lpos.z].isPlant)
                        {
                            Blocks[lpos.x, lpos.y + 1, lpos.z] = BlockType.Air;
                        }
                    }
                    else
                    {
                        if (NeighborUp.Blocks[lpos.x, 0, lpos.z].isPlant)
                        {
                            NeighborUp.Blocks[lpos.x, 0, lpos.z] = BlockType.Air;
                        }
                    }
                }
            }

        }

        ChunkManager.TouchedChunks.Add(this);

        DestroyBlocks.Clear();

        return;
    }

   

 public void WaterFlowCheck(int x, int y, int z)
    {
       

        if (y == 0)
        {
            if (NeighborDown.shareBlocks)
                NeighborDown.SwitchBlocks();
            if (NeighborDown.Blocks[x, _sizeSmallOne.y, z].isAir)
            {
                NeighborDown.Blocks[x, _sizeSmallOne.y, z] = BlockType.Water;
                NeighborDown.WaterFlowCheck(x, _sizeSmallOne.y, z);
            }


            ChunkManager.TouchedChunks.Add(NeighborDown);

        }
        else
        {

            if (Blocks[x, y - 1, z].isAir)
            {
                Blocks[x, y - 1, z] = BlockType.Water;
                WaterFlowCheck(x, y - 1, z);
            }
        }

        if (x == 0)
        {
            if (NeighborLeft.shareBlocks)
                NeighborLeft.SwitchBlocks();
            if (NeighborLeft.Blocks[_sizeSmallOne.x, y, z].isAir)
            {

                NeighborLeft.Blocks[_sizeSmallOne.x, y, z] = BlockType.Water;
                NeighborLeft.WaterFlowCheck(_sizeSmallOne.x, y, z);
            }

            ChunkManager.TouchedChunks.Add(NeighborLeft);
        }
        else if (x == _sizeSmallOne.x)
        {
            if (NeighborRight.shareBlocks)
                NeighborRight.SwitchBlocks();
            if (NeighborRight.Blocks[0, y, z].isAir)
            {
                NeighborRight.Blocks[0, y, z] = BlockType.Water;
                NeighborRight.WaterFlowCheck(0, y, z);
            }




            ChunkManager.TouchedChunks.Add(NeighborRight);
        }
        else
        {
            if (Blocks[x + 1, y, z].isAir)
            {
                Blocks[x + 1, y, z] = BlockType.Water;
                WaterFlowCheck(x + 1, y, z);
            }
            if (Blocks[x - 1, y, z].isAir)
            {
                Blocks[x - 1, y, z] = BlockType.Water;
                WaterFlowCheck(x - 1, y, z);
            }
        }


        if (z == 0)
        {
            if (NeighborBack.shareBlocks)
                NeighborBack.SwitchBlocks();
            if (NeighborBack.Blocks[x, y, _sizeSmallOne.z].isAir)
            {
                NeighborBack.Blocks[x, y, _sizeSmallOne.z] = BlockType.Water;
                NeighborBack.WaterFlowCheck(x, y, _sizeSmallOne.z);
            }


            ChunkManager.TouchedChunks.Add(NeighborBack);

        }
        else if (z == _sizeSmallOne.z)
        {
            if (NeighborForward.shareBlocks)
                NeighborForward.SwitchBlocks();
            if (NeighborForward.Blocks[x, y, 0].isAir)
            {
                NeighborForward.Blocks[x, y, 0] = BlockType.Water;
                NeighborForward.WaterFlowCheck(x, y, 0);
            }


            ChunkManager.TouchedChunks.Add(NeighborForward);
        }
        else
        {
            if (Blocks[x, y, z + 1].isAir)
            {
                Blocks[x, y, z + 1] = BlockType.Water;
                WaterFlowCheck(x, y, z + 1);
            }
            if (Blocks[x, y, z - 1].isAir)
            {
                Blocks[x, y, z - 1] = BlockType.Water;
                WaterFlowCheck(x, y, z - 1);
            }
        }



    }


    public static Stack<WorldChunk> pool = new Stack<WorldChunk>(10000);
    public static WorldChunk GetChunk()
    {
        WorldChunk chunk;
        if (pool.Count > 0)
        {
            chunk = pool.Pop();
        }
        else
        {
            chunk = Instantiate<WorldChunk>(ChunkManager.Instance.ChunkPrefab);
        }
        return chunk;
    }



    public static BlockType[,,] StoneBlocks;
    public static BlockType[,,] bedrockBlocks;
    public static BlockType[,,] AirBlocks;
    public bool shareBlocks;


    public void SwitchBlocks()
    {
        shareBlocks = false;

        if (Blocks == StoneBlocks)
        {
            Blocks = null;
            Blocks = GetBlocks();
            for (int x = 0; x < ChunkManager.Instance.chunkSize.x; x++)
            {
                for (int z = 0; z < ChunkManager.Instance.chunkSize.z; z++)
                {
                    hightmap[x, z] = _sizeSmallOne.y;
                    for (int y = 0; y < ChunkManager.Instance.chunkSize.y; y++)
                    {
                        Blocks[x, y, z] = BlockType.Stone;
                    }
                }
            }
        }

        if (Blocks == bedrockBlocks)
        {
            Blocks = null;
            Blocks = GetBlocks();
            for (int x = 0; x < ChunkManager.Instance.chunkSize.x; x++)
            {
                for (int z = 0; z < ChunkManager.Instance.chunkSize.z; z++)
                {
                    hightmap[x, z] = _sizeSmallOne.y;
                    for (int y = 0; y < ChunkManager.Instance.chunkSize.y; y++)
                    {
                        Blocks[x, y, z] = BlockType.Bedrock;
                    }
                }
            }
        }
        if (Blocks == AirBlocks)
        {
            Blocks = null;
            Blocks = GetBlocks();
            for (int x = 0; x < ChunkManager.Instance.chunkSize.x; x++)
            {
                for (int z = 0; z < ChunkManager.Instance.chunkSize.z; z++)
                {
                    for (int y = 0; y < ChunkManager.Instance.chunkSize.y; y++)
                    {
                        Blocks[x, y, z] = BlockType.Air;
                    }
                }
            }
        }
    }

    public static Stack<BlockType[,,]> BlocksPool = new Stack<BlockType[,,]>(1024);
    public static BlockType[,,] GetBlocks()
    {
        BlockType[,,] block;
        if (BlocksPool.Count > 0)
        {
            block = BlocksPool.Pop();
        }
        else
        {
            block = new BlockType[ChunkManager.Instance.chunkSize.x, ChunkManager.Instance.chunkSize.y, ChunkManager.Instance.chunkSize.z];


        }

        return block;
    }



}
