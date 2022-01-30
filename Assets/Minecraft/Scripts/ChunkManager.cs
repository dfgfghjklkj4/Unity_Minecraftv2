using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using Random = UnityEngine.Random;

public class ChunkManager : MonoBehaviour
{
    public WorldChunk airChunk;
    public WorldChunk bedrockChunk;
    public static float groundHight;
    public static float maxHight = 200;///82

    public bool useRandomSeed;
    public int seed;

    public Transform player;
    public Vector3Int loadDistance;
    Vector3Int loadDistancesmallone, loadDistancebigone;
    public Vector3Int chunkSize;
    public Texture2D blockAtlas;
    public Texture2D blockAtlas_N;
    public Material Opaque, Water, Foliage, TreeMat, Opaquelod2, WaterLod2, Foliagelod2;
    public WorldChunk ChunkPrefab;


    public static Dictionary<Vector3Int, WorldChunk> _chunks; // All chunks that have been initialized
    public static Dictionary<Vector3Int, WorldChunk> loadingChunks; // All chunks that have been load

    public static Vector3Int ChunkSize, LoadDistance;

    public List<WorldChunk> LoadChunkQueue;
    public List<WorldChunk> UnloadChunkQueue;

    //  private Vector3Int _prevPlayerChunk;

    public static ChunkManager Instance;





    private void Awake()

    {
       WorldChunk. NeiBlocks = new NeighborBlocks[6];
       for (int i = 0; i <WorldChunk. NeiBlocks.Length; i++)
       {
            WorldChunk. NeiBlocks[i]=new NeighborBlocks();
       }
  MeshData_.InitCacah();
        Instance = this;
        BlockType.LoadBlockTypes();
        WorldChunk.bedrockBlocks = new BlockType[chunkSize.x, chunkSize.y, chunkSize.z];

        for (int x = 0; x < chunkSize.x; x++)
        {
            for (int z = 0; z < chunkSize.z; z++)
            {

                for (int y = 0; y < chunkSize.y; y++)
                {
                    WorldChunk.bedrockBlocks[x, y, z] = BlockType.Bedrock;
                }
            }
        }

        WorldChunk.StoneBlocks = new BlockType[chunkSize.x, chunkSize.y, chunkSize.z];

        for (int x = 0; x < chunkSize.x; x++)
        {
            for (int z = 0; z < chunkSize.z; z++)
            {

                for (int y = 0; y < chunkSize.y; y++)
                {
                    WorldChunk.StoneBlocks[x, y, z] = BlockType.Stone;
                }
            }
        }
        WorldChunk.AirBlocks = new BlockType[chunkSize.x, chunkSize.y, chunkSize.z];

        for (int x = 0; x < chunkSize.x; x++)
        {
            for (int z = 0; z < chunkSize.z; z++)
            {

                for (int y = 0; y < chunkSize.y; y++)
                {
                    WorldChunk.AirBlocks[x, y, z] = BlockType.Air;
                }
            }
        }

        ChunkSize = chunkSize;
        LoadDistance = loadDistance;
        WorldChunk._size = ChunkSize;
        int lw = (loadDistance.x * 2 + 1) * (loadDistance.z * 2 + 1);
        for (int i = 0; i < lw; i++)
        {
            //  WorldChunk.highMapPool.Enqueue(new PerlinNoisePreCompute[chunkSize.x,chunkSize.z]);
            PerlinNoisePreCompute pc = new PerlinNoisePreCompute();
            WorldChunk.PerlinDatePool.Enqueue(pc);
        }

        for (int i = 0; i < 1024; i++)
        {
            var b = new BlockType[chunkSize.x, chunkSize.y, chunkSize.z];
            for (int x = 0; x < chunkSize.x; x++)
            {
                for (int y = 0; y < chunkSize.y; y++)
                {

                    for (int z = 0; z < chunkSize.z; z++)
                    {
                        b[x, y, z] = BlockType.Air;
                    }
                }
            }
            WorldChunk.BlocksPool.Push(b);
        }

        WorldChunk._sizeSmallOne = new Vector3Int(chunkSize.x - 1, chunkSize.y - 1, chunkSize.z - 1);
        WorldChunk._size = chunkSize;
        WorldChunk.boundCenter = new Vector3(chunkSize.x / 2 - 0.5f, chunkSize.y / 2 - 0.5f, chunkSize.z / 2 - 0.5f);
        WorldChunk.bound = new Bounds(WorldChunk.boundCenter, chunkSize);


      

    }

    private void OnDestroy()
    {
        GC.Collect();
        Debug.Log(1);
    }
    private void Start()
    {

        loadDistancesmallone = new Vector3Int(loadDistance.x - 1, loadDistance.y, loadDistance.z - 1);
        loadDistancebigone = new Vector3Int(loadDistance.x + 1, loadDistance.y + 1, loadDistance.z + 1);

        Initialize();
    }

    //  public WorldChunk preChunk, currentChunk;
    public Vector3Int preChunkPos;
    public Vector3Int currentChunkPos;

    public static bool ChangeChunk;
    private void Update()
    {


        if (ChangeChunk)
            ChangeChunk = false;


        currentChunkPos = GetNearestChunkPosition(GetPlayerPosition());
        if (LoadChunkQueue.Count > 0)
        {
            LoadChunksYield();

        }


    }

    private void LateUpdate()
    {

        if (currentChunkPos != preChunkPos)
        {

            ChangeChunk = true;
            UpdateLoadedChunks();

        }
        ///////////////////////////////////
        if (destroyChunks.Count > 0 || addChunks.Count > 0)
        {
            ModifyAndUpdateBlocks();
        }





        if (currentChunkPos != preChunkPos)
        {

            preChunkPos = currentChunkPos;
        }


    }

    List<Vector2Int> templistkey = new List<Vector2Int>();
    List<WorldChunk> UnloadChunkQueuetemp = new List<WorldChunk>(64);
    private void FixedUpdate()
    {



        int c = UnloadChunkQueue.Count - 128;
        if (c > 0)
        {
            UnloadChunkQueuetemp.Clear();
            int ccc = 0;
            for (int i = 0; i < c; i++)
            {
                ccc++;

                UnloadChunkQueue[i].UnUseSet();

                UnloadChunkQueuetemp.Add(UnloadChunkQueue[i]);
                // UnloadChunkQueue.RemoveAt(i);
                if (ccc > 10)
                {
                    break;
                }
            }
            foreach (var item in UnloadChunkQueuetemp)
            {
                UnloadChunkQueue.Remove(item);
            }
        }



        c = WorldChunk.hightMapDic.Count - 1024;
        if (c > 50 && LoadChunkQueue.Count == 0)
        {
            int cc = 0;
            foreach (var ky in WorldChunk.hightMapDic)
            {
                cc++;
                templistkey.Add(ky.Key);
                if (cc == c)
                {
                    break;
                }
            }
            for (int i = 0; i < templistkey.Count; i++)
            {
                WorldChunk.PerlinDatePool.Enqueue(WorldChunk.hightMapDic[templistkey[i]]);
                WorldChunk.hightMapDic.Remove(templistkey[i]);
            }
            templistkey.Clear();
        }
    }

    private void OnDisable()
    {
        MeshData_.triangles.Dispose();
    }
    public static Random.State prevState;
    public static Vector2Int offset;
    public void Initialize()
    {


        var v = GetPlayerPosition();

        currentChunkPos = GetNearestChunkPosition(v);




        if (useRandomSeed)
        {
            seed = UnityEngine.Random.Range(int.MinValue, int.MaxValue);
        }
        prevState = Random.state;
        UnityEngine.Random.InitState(seed);
        offset = new Vector2Int(Random.Range(-100, 100), Random.Range(-100, 100));

        _chunks = new Dictionary<Vector3Int, WorldChunk>(2048); // All chunks that have been initialized
        loadingChunks = new Dictionary<Vector3Int, WorldChunk>(2048); // All chunks that have been load

        LoadChunkQueue = new List<WorldChunk>(128);

        UnloadChunkQueue = new List<WorldChunk>(128);

        TouchedChunks = new HashSet<WorldChunk>();

        addChunks = new HashSet<WorldChunk>();

        modifyChunks = new HashSet<WorldChunk>();

        destroyChunks = new HashSet<WorldChunk>();

        newChunks = new HashSet<WorldChunk>();

        preChunkPos = Vector3Int.one * int.MaxValue;

        var loadPos = GetInRangeChunkPositions(currentChunkPos, loadDistance);

        LoadChunksImmediately(loadPos);

    }
    public int totolVc;

    private void LoadChunksImmediately(List<Vector3Int> loadPos)
    {
        MeshData_.tiem = 0;
        int c = loadDistance.x * loadDistance.z * loadDistance.y;
        for (int i = 0; i < 1024; i++)
        {

            WorldChunk chunk = Instantiate<WorldChunk>(ChunkPrefab);

            chunk.Blocks = new BlockType[chunkSize.x, chunkSize.y, chunkSize.z];
            chunk.hightmap = new int[ChunkManager.Instance.chunkSize.x, ChunkManager.Instance.chunkSize.z];
            chunk.Active();
            chunk.hideFlags = HideFlags.HideInHierarchy;

            WorldChunk.pool.Push(chunk);
            // go.gameObject.SetActive(false);
        }

        float f = Time.realtimeSinceStartup;
        foreach (var item in loadPos)


        {
            Vector3Int chunkID = item;

            WorldChunk chunk;
            if (_chunks.TryGetValue(chunkID, out chunk))
            {

            }
            else
            {


                chunk = WorldChunk.GetChunk();
            }


            chunk.Initialize(chunkID);


            chunk.CreateTerrainDate();
            LoadNextChunk(chunk);
            //   */

        }
        loadPos.Clear();
        f = Time.realtimeSinceStartup - f;
        // PlayerController.Instance.tm.text = f.ToString();
        Debug.Log(f + "   总时间  " + loadingChunks.Count + " vc " + totolVc);
        //  Debug.Log(MeshData_.tiem);

    }


    private void LoadChunksYield()
    {
        UnloadChunkQueuetemp.Clear();
        int loadCount = 0;
        int cc = 0;
        int c = LoadChunkQueue.Count - 1;//直接用gos.Count - 1或c
        for (int i = 0; i < LoadChunkQueue.Count; i++)
        {
            var chunk = LoadChunkQueue[i];


            if (LoadNextChunk(chunk))
            {
                loadCount++;
            }


            chunk.flag = LoadFlag.loaded;
            cc++;
            UnloadChunkQueuetemp.Add(LoadChunkQueue[i]);
            if (cc > 50 || loadCount > 15)
            {
                break;
            }
        }
        foreach (var item in UnloadChunkQueuetemp)
        {
            LoadChunkQueue.Remove(item);
        }

    }



    /// <summary>
    /// (105, 69, -111)
    /// Load the next chunk in the chunk load queue.
    /// </summary>
    private bool LoadNextChunk(WorldChunk chunk)
    {

        if (chunk.buildMesh == false)
        {

            {

                chunk.StartBuildMesh();
                if (chunk.IsLoaded)
                {

                    return true;

                }

                return false;
            }

        }

        return false;
    }

    public static WorldChunk GetChunk(Vector3Int chunkID)
    {

        WorldChunk chunk;
        if (!_chunks.TryGetValue(chunkID, out chunk))
        {
            if (chunkID.y > ChunkManager.maxHight)
            {
                chunk = Instance.airChunk;

            }
            else if (chunkID.y < -49)
            {
                chunk = Instance.bedrockChunk;
            }
            else
            {
                chunk = WorldChunk.GetChunk();
                chunk.Initialize(chunkID);
            }


        }
        else
        {
            chunk.Initialize(chunkID);


        }

        return chunk;

    }

    //   public static CustomWorldChunkComparer cwc = new CustomWorldChunkComparer();
    public static HashSet<WorldChunk> TouchedChunks;
    public static HashSet<WorldChunk> addChunks;
    public static HashSet<WorldChunk> modifyChunks;
    public static HashSet<WorldChunk> destroyChunks;
    public static HashSet<WorldChunk> newChunks;




    //当前更新只支持每帧只能移动一个chunk大小的距离 
    //暂时都放在一帧里处理
    public void UpdateLoadedChunks()
    {
        int uc = UnloadChunkQueue.Count;
        //
        //    print(preChunkPos+"  " + currentChunkPos);
        for (int dx = -loadDistancebigone.x; dx <= loadDistancebigone.x; dx += 1)
        {
            for (int dz = -loadDistancebigone.z; dz <= loadDistancebigone.z; dz += 1)

            {
                //最外面的一圈
                if (dx == -loadDistancebigone.x || dx == loadDistancebigone.x || dz == -loadDistancebigone.z || dz == loadDistancebigone.z)
                {
                    for (int dy = loadDistancebigone.y; dy >= -loadDistancebigone.y; dy -= 1)
                    {

                        if (dy * chunkSize.y + preChunkPos.y > maxHight)
                        {
                            continue;
                        }
                        Vector3 offset = new Vector3(dx * chunkSize.x, dy * chunkSize.y, dz * chunkSize.z);
                        Vector3Int pos = preChunkPos + Vector3Int.RoundToInt(offset);
                        // if (!UnloadChunkQueue.Contains(pos))
                        // {
                        //    UnloadChunkQueue.Add(pos);
                        // }
                        if (_chunks.TryGetValue(pos, out WorldChunk chunk))
                        {

                            if (chunk.flag == LoadFlag.waitLoad)
                            {
                                LoadChunkQueue.Remove(chunk);
                            }
                            if (!UnloadChunkQueue.Contains(chunk))
                            {
                                UnloadChunkQueue.Add(chunk);
                                //  chunk.gameObject.SetActive(false);
                                chunk.flag = LoadFlag.waitUnload;
                            }

                        }

                    }

                }//关掉变化前位置的chunk lod设置（离相机最近3圈chunk）
                else if ((Mathf.Abs(dx) == 3 && Mathf.Abs(dz) <= 3) || (Mathf.Abs(dz) == 3 && Mathf.Abs(dx) <= 3))

                {

                    for (int dy = loadDistance.y; dy >= -loadDistance.y; dy -= 1)
                    {
                        if (dy * chunkSize.y + currentChunkPos.y > maxHight)
                        {
                            continue;
                        }
                        Vector3 offset = new Vector3(dx * chunkSize.x, dy * chunkSize.y, dz * chunkSize.z);
                        Vector3Int pos = preChunkPos + Vector3Int.RoundToInt(offset);

                        if (_chunks.TryGetValue(pos, out WorldChunk chunk))
                        {

                            // chunk.LOD = 1;


                            if (chunk.OpaqueMeshFilter.sharedMesh.vertexCount > 0 && chunk.OpaqueMeshCol.enabled)
                            {
                             //   chunk.OpaqueMeshRenderer.shadowCastingMode = ShadowCastingMode.Off;
                             //   chunk.OpaqueMeshRenderer.receiveShadows = false;
                             //   chunk.OpaqueMeshCol.enabled = false;
                             //   chunk.OpaqueMeshRenderer.sharedMaterial = Opaquelod2;
                            }

                            if (chunk.FoliageMeshFilter.sharedMesh.vertexCount > 0 && chunk.FoliageMeshCol.gameObject.activeSelf)
                            {
                                //  chunk.FoliageMeshRenderer.shadowCastingMode = ShadowCastingMode.Off;
                                //  chunk.FoliageMeshRenderer.receiveShadows = false;
                                // chunk.FoliageMeshRenderer.sharedMaterial = Foliagelod2;
                                // chunk.FoliageMeshCol.enabled = false;
                            //    chunk.FoliageMeshCol.gameObject.SetActive(false);
                            }
                            if (chunk.WaterMeshFilter.sharedMesh.vertexCount > 0 && chunk.WaterMeshCol.enabled)
                            {

                                chunk.WaterMeshRenderer.shadowCastingMode = ShadowCastingMode.Off;
                                chunk.WaterMeshRenderer.receiveShadows = false;
                                chunk.WaterMeshRenderer.sharedMaterial = WaterLod2;
                                chunk.WaterMeshCol.enabled = false;
                            }



                        }


                    }

                }
            }
        }




        ////////////////////////////////////////////////////////////////////
        for (int dx = -loadDistance.x; dx <= loadDistance.x; dx += 1)
        {
            for (int dz = -loadDistance.z; dz <= loadDistance.z; dz += 1)

            {
                //以当前chunk位置为中心 加载到最外边的chunk也就是变化的chunk（规定一帧最多加载一个chunk 所以变化的也就是最外边的一圈chunk）
                // if (dx == -loadDistance.x || dx == loadDistance.x || dz == -loadDistance.z || dz == loadDistance.z)
                if (dx == -loadDistance.x || dx == loadDistance.x || dz == -loadDistance.z || dz == loadDistance.z || dx == -loadDistancesmallone.x || dx == loadDistancesmallone.x || dz == -loadDistancesmallone.z || dz == loadDistancesmallone.z)
                {
                    for (int dy = loadDistance.y; dy >= -loadDistance.y; dy -= 1)
                    {

                        if (dy * chunkSize.y + currentChunkPos.y > maxHight)
                        {
                            continue;
                        }
                        Vector3 offset = new Vector3(dx * chunkSize.x, dy * chunkSize.y, dz * chunkSize.z);
                        Vector3Int pos = currentChunkPos + Vector3Int.RoundToInt(offset);

                        if (_chunks.TryGetValue(pos, out WorldChunk chunk))
                        {//这里大多是已经加载了地形数据的邻居块
                            if (chunk.flag == LoadFlag.waitUnload)
                            {
                                if (!chunk.gameObject.activeSelf)
                                {
                                    chunk.gameObject.SetActive(true);
                                }

                                UnloadChunkQueue.Remove(chunk);
                                chunk.flag = LoadFlag.loaded;
                            }
                            else
                            {
                                //   LoadChunkQueue.Add(chunk);
                                if (!chunk.buildMesh)
                                {
                                    if (!LoadChunkQueue.Contains(chunk))
                                    {
                                        chunk.flag = LoadFlag.waitLoad;
                                        LoadChunkQueue.Add(chunk);
                                    }
                                }
                            }

                        }
                        else
                        {//新加载的chunk
                            var newChunk = GetChunk(pos);
                            newChunk.flag = LoadFlag.waitLoad;
                            LoadChunkQueue.Add(newChunk);



                        }

                    }

                }
                //离相机最近的3圈chunk
                else if (Mathf.Abs(dx) <= 2 && Mathf.Abs(dz) <= 2)
                //   else if (Mathf.Abs(dx) == 1 && Mathf.Abs(dz) == 1)
                {

                    for (int dy = loadDistance.y; dy >= -loadDistance.y; dy -= 1)
                    {
                        if (dy * chunkSize.y + currentChunkPos.y > maxHight)
                        {
                            // continue;
                        }
                        Vector3 offset = new Vector3(dx * chunkSize.x, dy * chunkSize.y, dz * chunkSize.z);
                        Vector3Int pos = currentChunkPos + Vector3Int.RoundToInt(offset);
                        //  GameObject.Instantiate(red, pos, Quaternion.identity);

                        if (_chunks.TryGetValue(pos, out WorldChunk chunk))
                        {
                            if (chunk.IsLoaded)
                            {
                                // chunk.LOD = 0;





                                if (chunk.OpaqueMeshFilter.sharedMesh.vertexCount > 0 && !chunk.OpaqueMeshCol.enabled)
                                {
                                   // chunk.OpaqueMeshRenderer.shadowCastingMode = ShadowCastingMode.On;
                                   // chunk.OpaqueMeshRenderer.receiveShadows = true;
                                   // chunk.OpaqueMeshCol.enabled = true;
                                   // chunk.OpaqueMeshRenderer.sharedMaterial = Opaque;
                                }

                                if (chunk.FoliageMeshFilter.sharedMesh.vertexCount > 0 && !chunk.FoliageMeshCol.gameObject.activeSelf)
                                {
                                    // chunk.FoliageMeshRenderer.shadowCastingMode = ShadowCastingMode.On;
                                    //  chunk.FoliageMeshRenderer.receiveShadows = true;
                                    //  chunk.FoliageMeshCol.enabled = true;
                                    //  chunk.FoliageMeshRenderer.sharedMaterial = Foliage;
                                 //   chunk.FoliageMeshCol.gameObject.SetActive(true);
                                }
                                if (chunk.WaterMeshFilter.sharedMesh.vertexCount > 0 && !chunk.WaterMeshCol.enabled)
                                {

                                    // chunk.WaterMeshRenderer.shadowCastingMode = ShadowCastingMode.On;
                                    chunk.WaterMeshRenderer.receiveShadows = true;
                                    chunk.WaterMeshCol.enabled = true;
                                    chunk.WaterMeshRenderer.sharedMaterial = Water;
                                }




                            }
                        }
                    }
                }
            }
        }

        for (int i = uc; i < UnloadChunkQueue.Count; i++)
        {
            UnloadChunkQueue[i].gameObject.SetActive(false);
        }
    }








    private List<Vector3Int> GetInRangeChunkPositions(Vector3Int centerChunkPos, Vector3Int radius)
    {
        List<Vector3Int> loadPos = new List<Vector3Int>(1024);
        // float maxDistSqrd = Mathf.Pow(radius.x * chunkSize.x, 2f);

        for (int dx = -radius.x; dx <= radius.x; dx += 1)
        {
            for (int dz = -radius.z; dz <= radius.z; dz += 1)

            {
                // for (int dy = -radius.y; dy <= radius.y; dy += 1)
                //从上向下加载
                for (int dy = radius.y; dy >= -radius.y; dy -= 1)
                {
                    if (dy * chunkSize.y < -49)
                    {
                        //  print(dy * chunkSize.y + centerChunkPos.y);
                        break;
                    }
                    if (dy * chunkSize.y + centerChunkPos.y > maxHight)
                    {
                        continue;
                    }
                    Vector3 offset = new Vector3(dx * chunkSize.x, dy * chunkSize.y, dz * chunkSize.z);
                    Vector3Int pos = centerChunkPos + Vector3Int.RoundToInt(offset);

                    if (!_chunks.ContainsKey(pos))
                    {
                        loadPos.Add(pos);
                    }
                    else
                    {
                        WorldChunk chunk = _chunks[pos];
                        if (!chunk.buildMesh)
                        {
                            loadPos.Add(pos);
                        }

                    }
                }
            }
        }
        return loadPos;
    }




    static Vector3Int offset2 = new Vector3Int(int.MaxValue / 2, int.MaxValue / 2, int.MaxValue / 2);
    public static Vector3Int GetNearestChunkPosition(Vector3Int pos)
    {
        //   Vector3Int offset = new Vector3Int(int.MaxValue / 2, int.MaxValue / 2, int.MaxValue / 2);
        pos += offset2;

        int xi = pos.x / ChunkSize.x;
        int yi = pos.y / ChunkSize.y;
        int zi = pos.z / ChunkSize.z;

        int x = xi * ChunkSize.x;
        int y = yi * ChunkSize.y;
        int z = zi * ChunkSize.z;

        return new Vector3Int(x, y, z) - offset2;
    }


    public static WorldChunk GetNearestChunk(Vector3Int pos)
    {
        Vector3Int nearestPos = GetNearestChunkPosition(pos);
        //  WorldChunk chunk;
        return GetChunk(nearestPos);


    }



    public BlockType GetBlockAtPosition(Vector3Int pos, ref WorldChunk chunk)
    {
        chunk = GetNearestChunk(pos);
        if (chunk == null)
        {
            Debug.LogError("加载了错误的chunk");
            return null;
        }
        return chunk.GetBlockAtWorldPosition(pos);
    }


    Vector3Int GetPlayerPosition()
    {
        Vector3Int pos = Vector3Int.CeilToInt(player.transform.position);
        if (pos.y > maxHight)
            pos.y = (int)maxHight;
        return pos;
    }
    public static Vector3Int GetPlayerPosition(Transform tf)
    {
        //   Vector3Int pos = Vector3Int.CeilToInt(tf.position);
        Vector3Int pos = Vector3Int.RoundToInt(tf.position);
        if (pos.y > maxHight)
            pos.y = (int)maxHight;
        return pos;
    }

    public List<Transform> trees;
    public List<Transform> trees2;
    public GameObject gp;

    public GameObject ggg;
    void ModifyAndUpdateBlocks()
    {
        foreach (var chunk in destroyChunks)
        {
            //  print(23);
            chunk.loadNeighborsBlocks();
            chunk.DesttroyBlocksFun();
            chunk.DestroyBlocks.Clear();

        }
        foreach (var chunk in TouchedChunks)
        {
             if (!chunk.isModify)
         chunk.isModify=true;
            if (chunk.buildMesh)
            {
                chunk.ReBuildMesh();
            }
            else
            {
                //   print(chunk.ID);
                chunk.CreateTerrainDate();
                chunk.ReBuildMesh();
            }

        }

        foreach (var chunk in addChunks)
        {
            if (chunk.buildMesh)
            {
                chunk.CreateTerrainDate();
                chunk.ReBuildMesh();
            }
            else
            {


                chunk.ReBuildMesh();
            }

        }
        destroyChunks.Clear();
        TouchedChunks.Clear();
        addChunks.Clear();
    }


}
